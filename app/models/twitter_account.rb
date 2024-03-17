class TwitterAccount < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  scope :primary, -> { where(primary: true) }
  scope :not_primary, -> { where(primary: false) }
  scope :verified, -> { where(verified: true) }
  scope :not_verified, -> { where(verified: false) }

  def self.verify!(code:)
    uri = URI.parse("https://api.twitter.com/2/oauth2/token")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(client_id:, grant_type:, refresh_token:)

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    binding.irb
  end

  def self.grant_type
    :refresh_token
  end

  def self.authorize_url
    "https://twitter.com/i/oauth2/authorize?#{encoded_params}"
  end

  def self.encoded_params
    params.map do |key, value|
      "#{ERB::Util.url_encode(key.to_s)}=#{ERB::Util.url_encode(value.to_s)}"
    end.join("&")
  end

  def self.params
    {
      client_id:,
      code_challenge:,
      code_challenge_method:,
      code_verifier:,
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
    Base64.urlsafe_encode64(
      SecureRandom.random_bytes(16),
      padding: false
    )
  end

  def self.code_verifier
    Base64.urlsafe_encode64(
      SecureRandom.random_bytes(32),
      padding: false
    )
  end

  def self.code_challenge
    Base64.urlsafe_encode64(
      OpenSSL::Digest::SHA256.digest(code_verifier),
      padding: false
    )
  end

  def self.code_challenge_method
    :s256
  end

  def self.client_id
    Rails.application.credentials.api_twitter_com.api_key
  end

  def self.client_secret
    Rails.application.credentials.api_twitter_com.api_key_secret
  end

  def self.redirect_uri
    Rails.application.routes.url_helpers.auth_twitter_callback_url
  end

  def self.scope
    [
      "tweet.read",
      "tweet.write",
      "tweet.moderate.write",
      "users.read",
      "follows.read",
      "follows.write",
      "offline.access",
      "space.read",
      "mute.read",
      "mute.write",
      "like.read",
      "like.write",
      "list.read",
      "list.write",
      "block.read",
      "block.write",
      "bookmark.read",
      "bookmark.write"
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

  def to_s
    "twitter_account##{id}"
  end
end
