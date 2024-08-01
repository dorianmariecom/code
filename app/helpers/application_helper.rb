# frozen_string_literal: true

module ApplicationHelper
  def title
    controller = controller_name
    action = action_name
    action = "new" if action == "create"
    action = "edit" if action == "update"
    content_for(:title).presence || t("#{controller}.#{action}.title")
  end

  def fake_slack_teams
    3.times.map { Faker::Internet.username(separators: []) }.join(", ")
  end

  def google_maps_api_key
    Rails.application.credentials.console_cloud_google_com.api_key
  end

  def fake_locations
    3.times.map { Faker::Address.full_address }
  end

  def fake_verification_codes(n: 4)
    3.times.map { rand(10**n).to_s.rjust(n, "0") }
  end

  def fake_email_addresses
    3.times.map { Faker::Internet.email }
  end

  def fake_phone_numbers
    3.times.map { Faker::PhoneNumber.phone_number_with_country_code }
  end

  def fake_passwords
    3.times.map { Faker::Internet.password }
  end

  def fake_time_zones
    TimeZone::TIME_ZONES.sample(3)
  end

  def fake_names
    3.times.map { Faker::Name.name }
  end

  def fake_smtp_display_names
    3.times.map { Faker::Name.name }
  end

  def fake_smtp_addresses
    %w[
      smtp.gmail.com
      smtp.mail.yahoo.com
      smtp.office365.com
      smtp.aol.com
      smtp.mail.me.com
      smtp.bizmail.yahoo.com
      smtpcorp.com
      smtp.mailgun.org
      smtp.mailchimp.com
    ]
  end

  def fake_smtp_ports
    [465, 587]
  end

  def fake_smtp_user_names
    3.times.map { Faker::Internet.email }
  end

  def fake_smtp_passwords
    3.times.map { Faker::Internet.password }
  end

  def fake_smtp_authentications
    %w[plain login cram_md5 none]
  end

  def fake_data
    "1, true, { 123: false }, [1, 2, 3]"
  end

  def time_zone_options(time_zone: nil)
    TimeZone::TIME_ZONES.map do |option_time_zone|
      [
        option_time_zone,
        option_time_zone,
        { selected: option_time_zone == time_zone }
      ]
    end
  end

  def schedule_interval_options(interval: nil)
    Schedule::INTERVALS.map do |option_interval|
      [
        option_interval,
        option_interval,
        { selected: option_interval == interval }
      ]
    end
  end

  def device_platform_options(platform: nil)
    Device::PLATFORMS.map do |device_platform|
      [
        device_platform,
        device_platform,
        { selected: device_platform == platform }
      ]
    end
  end

  def user_options(user_id: nil)
    ([nil] + policy_scope(User).order(:id).to_a).map do |user|
      [user&.to_s, user&.id, { selected: user_id == user&.id }]
    end
  end

  def program_options(program_id: nil)
    policy_scope(Program)
      .order(:id)
      .to_a
      .map do |program|
        [program&.to_s, program&.id, { selected: program_id == program&.id }]
      end
  end

  def default_country_code
    PhoneNumber::DEFAULT_COUNTRY_CODE
  end

  def email_address_regexp
    json_regexp(EmailAddress::EMAIL_ADDRESS_REGEXP)
  end

  def domain_regexp
    json_regexp(SmtpAccount::DOMAIN_REGEXP)
  end

  def verification_code_regexp
    json_regexp(PhoneNumber::VERIFICATION_CODE_REGEXP)
  end

  def slack_team_regexp
    json_regexp(SlackAccount::TEAM_REGEXP)
  end

  def whatsapp_to(phone_number, name)
    phone_number = Phonelib.parse(phone_number).e164
    link_to(name, "https://wa.me/#{h(phone_number)}")
  end

  def json_regexp(regexp)
    str =
      regexp
        .inspect
        .sub('\\A', "^")
        .sub('\\Z', "$")
        .sub('\\z', "$")
        .sub(%r{^/}, "")
        .sub(%r{/[a-z]*$}, "")
        .gsub(/\(\?#.+\)/, "")
        .gsub(/\(\?-\w+:/, "(")
        .gsub(/\s/, "")
    Regexp.new(str).source
  end

  def registered?
    current_user.is_an?(User)
  end

  def guest?
    current_user.is_a?(Guest)
  end

  def tokens
    current_user.tokens.map(&:token)
  end

  def code_env
    if request.host == "localhost"
      "local"
    elsif request.host == "dev.codedorian.com"
      "dev"
    elsif request.host == "staging.codedorian.com"
      "staging"
    else
      "production"
    end
  end
end
