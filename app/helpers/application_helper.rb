# frozen_string_literal: true

module ApplicationHelper
  def title
    controller = controller_name
    action = action_name
    action = "new" if action == "create"
    action = "edit" if action == "update"
    content_for(:title).presence || t("#{controller}.#{action}.title")
  end

  def fake_inputs
    "1 + 1, :Hello * 10, Mail.send"
  end

  def fake_email_addresses
    3.times.map { Faker::Internet.email }
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
    [
      "smtp.gmail.com",
      "smtp.mail.yahoo.com",
      "smtp.office365.com",
      "smtp.aol.com",
      "smtp.mail.me.com",
      "smtp.bizmail.yahoo.com",
      "smtpcorp.com",
      "smtp.mailgun.org",
      "smtp.mailchimp.com"
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
      [
        user&.to_s,
        user&.id,
        { selected: user_id == user&.id }
      ]
    end
  end

  def email_address_regexp
    json_regexp(EmailAddress::EMAIL_ADDRESS_REGEXP)
  end

  def domain_regexp
    json_regexp(EmailAddress::DOMAIN_REGEXP)
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
