# frozen_string_literal: true

module ApplicationHelper
  def title
    controller = controller_name
    action = action_name
    action = "new" if action == "create"
    action = "edit" if action == "update"
    content_for(:title).presence || t("#{controller}.#{action}.title")
  end

  def google_maps_api_key
    Rails.application.credentials.console.cloud.google.com.api_key
  end

  def fake_locations
    3.times.map { Faker::Address.full_address }
  end

  def fake_prompts
    "Do a math operation, " \
      "Send an email to Elon Musk or " \
      "Send a slack message if it will be raining tomorrow"
  end

  def fake_inputs
    "1 + 1, :Hello * 10, Mail.send"
  end

  def fake_verification_codes
    3.times.map { rand(10_000).to_s.rjust(4, "0") }
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
    User::TIME_ZONES.sample(3)
  end

  def fake_names
    3.times.map { Faker::Name.name }
  end

  def fake_display_names
    3.times.map { Faker::Name.name }
  end

  def fake_program_names
    3.times.map { Faker::Book.title }
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

  def time_zone_options
    User::TIME_ZONES
  end

  def user_options(user_id: nil)
    ([nil] + policy_scope(User).order(:id).to_a).map do |user|
      [user&.to_s, user&.id, { selected: user_id == user&.id }]
    end
  end

  def default_country_code
    PhoneNumber::DEFAULT_COUNTRY_CODE
  end

  def email_address_regexp
    json_regexp(EmailAddress::EMAIL_ADDRESS_REGEXP)
  end

  def domain_regexp
    json_regexp(EmailAddress::DOMAIN_REGEXP)
  end

  def verification_code_regexp
    json_regexp(PhoneNumber::VERIFICATION_CODE_REGEXP)
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
end
