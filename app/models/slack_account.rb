class SlackAccount < ApplicationRecord
  BASE_URL = "https://slack.com"

  belongs_to :user, default: -> { Current.user }

  scope :primary, -> { where(primary: true) }
  scope :not_primary, -> { where(primary: false) }
  scope :verified, -> { where(verified: true) }
  scope :not_verified, -> { where(verified: false) }

  def self.find_by_team(team)
    SlackAccount.where(
      "auth->'team'->>'id' = ? OR auth->'team'->>'name' = ?",
      team,
      team
    ).first
  end

  def self.find_by_team!(team)
    find_by_team(team) || raise(ActiveRecord::RecordNotFound.new(team))
  end

  def self.verify!(code:)
    uri = URI.parse("#{BASE_URL}/api/oauth.v2.access")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(client_id:, client_secret:, code:)
    response =
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

    SlackAccount.create!(
      primary: Current.slack_accounts.none?,
      verified: true,
      auth: JSON.parse(response.body)
    ).tap(&:fetch_conversations!)
  end

  def self.authorize_url
    query = { scope:, client_id:, redirect_uri: }.to_query
    "#{BASE_URL}/oauth/v2/authorize?#{query}"
  end

  def self.client_id
    Rails.application.credentials.slack.com.client_id
  end

  def self.client_secret
    Rails.application.credentials.slack.com.client_secret
  end

  def self.redirect_uri
    Rails.application.routes.url_helpers.auth_slack_callback_url
  end

  def self.scope
    "chat:write,chat:write.public,channels:read"
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

  def fetch_conversations!
    uri = URI.parse("#{BASE_URL}/api/conversations.list")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{access_token}"

    response =
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

    update!(conversations: JSON.parse(response.body))
  end

  def channels
    conversations["channels"]
  end

  def team_id
    auth.dig("team", "id")
  end

  def team_name
    auth.dig("team", "name")
  end

  def access_token
    auth["access_token"]
  end

  def to_s
    team_name.presence || "SlackAccount##{id}"
  end
end
