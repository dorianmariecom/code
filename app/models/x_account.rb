class XAccount < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  scope :primary, -> { where(primary: true) }
  scope :not_primary, -> { where(primary: false) }
  scope :verified, -> { where(verified: true) }
  scope :not_verified, -> { where(verified: false) }

  def self.verify!(code:)
    uri = URI.parse("https://api.twitter.com/2/oauth2/token")
    request = Net::HTTP::Post.new(uri)
    request[:Authorization] = "Basic #{encoded_credentials}"
    request.set_form_data(
      client_id:,
      code:,
      code_verifier:,
      grant_type:,
      redirect_uri:
    )

    response =
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

    create!(
      primary: Current.x_accounts.none?,
      verified: true,
      auth: JSON.parse(response.body)
    ).tap(&:refresh_auth!).tap(&:refresh_me!)
  end

  def self.grant_type
    :authorization_code
  end

  def self.authorize_url
    "https://twitter.com/i/oauth2/authorize?#{encoded_params}"
  end

  def self.encoded_params
    params
      .map do |key, value|
        "#{ERB::Util.url_encode(key.to_s)}=#{ERB::Util.url_encode(value.to_s)}"
      end
      .join("&")
  end

  def self.params
    {
      client_id:,
      code_challenge:,
      code_challenge_method:,
      redirect_uri:,
      response_type:,
      scope:,
      state:
    }
  end

  def self.response_type
    :code
  end

  def self.state
    encode(Current.user!.signed_id(purpose:, expires_in: 1.day))
  end

  def self.purpose
    :x_account_authorize_uri
  end

  def self.encode(string)
    Base64.urlsafe_encode64(string, padding: false)
  end

  def self.code_verifier
    encode(Current.user!.to_signed_global_id(purpose:, expires_in: nil).to_s)
  end

  def self.code_challenge
    encode(OpenSSL::Digest::SHA256.digest(code_verifier))
  end

  def self.code_challenge_method
    :s256
  end

  def self.encoded_client_id
    URI.encode_www_form_component(client_id)
  end

  def self.encoded_client_secret
    URI.encode_www_form_component(client_secret)
  end

  def self.encoded_credentials
    Base64.strict_encode64("#{encoded_client_id}:#{encoded_client_secret}")
  end

  def self.client_id
    Rails.application.credentials.api_twitter_com.client_id
  end

  def self.client_secret
    Rails.application.credentials.api_twitter_com.client_secret
  end

  def self.redirect_uri
    Rails.application.routes.url_helpers.auth_x_callback_url
  end

  def self.scope
    %w[
      tweet.read
      tweet.write
      tweet.moderate.write
      users.read
      follows.read
      follows.write
      offline.access
      space.read
      mute.read
      mute.write
      like.read
      like.write
      list.read
      list.write
      block.read
      block.write
      bookmark.read
      bookmark.write
    ].join(" ")
  end

  def primary?
    !!primary
  end

  def not_primary?
    !primary?
  end

  def verified?
    !!verified
  end

  def not_verified?
    !verified?
  end

  def user_fields
    %w[
      id
      name
      username
      created_at
      description
      entities
      location
      pinned_tweet_id
      profile_image_url
      protected
      public_metrics
      url
      verified
      withheld
    ]
  end

  def me_query
    { "user.fields" => user_fields.join(",") }.to_query
  end

  def username
    me.fetch("username", nil)
  end

  def twitter_id
    me.fetch("id", nil)
  end

  def access_token
    auth.fetch("access_token", nil)
  end

  def refresh_token
    auth.fetch("refresh_token", nil)
  end

  def refresh_auth!
    if refresh_token.blank?
      update!(verified: false)
    else
      uri = URI.parse("https://api.twitter.com/2/oauth2/token")
      request = Net::HTTP::Post.new(uri)
      request["Authorization"] = authorization
      request.set_form_data(grant_type: :refresh_token, refresh_token:)

      response =
        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

      update!(auth: JSON.parse(response.body))
    end
  end

  def authorization
    "Basic #{Base64.urlsafe_encode64("#{client_id}:#{client_secret}")}"
  end

  def client_id
    self.class.client_id
  end

  def client_secret
    self.class.client_secret
  end

  def refresh_me!
    if access_token.blank?
      update!(verified: false)
    else
      uri = URI.parse("https://api.twitter.com/2/users/me?#{me_query}")
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = "Bearer #{access_token}"
      response =
        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end
      update!(me: JSON.parse(response.body).fetch("data"))
    end
  end

  def to_s
    username.presence || "x_account##{id}"
  end
end
