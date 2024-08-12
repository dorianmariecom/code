# frozen_string_literal: true

require "spec_helper"

ENV["RAILS_ENV"] ||= "test"

require_relative "../config/environment"

if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end

require "rspec/rails"

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

WebMock.disable_net_connect!(allow_localhost: true)

Capybara.server = :puma, { Silent: true }
Capybara.app_host = ENV.fetch("BASE_URL")
Capybara.server_host = ENV.fetch("HOST").split(":").first
Capybara.server_port = ENV.fetch("HOST").split(":").last

Capybara.register_driver :chrome do |app|
  chrome_options = Selenium::WebDriver::Chrome::Options.new
  chrome_options.add_argument("--disable-search-engine-choice-screen")
  chrome_options.add_argument("--headless") if ENV["HEADFULL"].blank?
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
end

Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome
Capybara.current_driver = :chrome

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods

  config.before { Current.user = create(:user, :admin) }
  config.after { Current.reset }
end
