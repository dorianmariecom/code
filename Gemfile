# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |name| "https://github.com/#{name}" }
git_source(:rails) { |name| "https://github.com/rails/#{name}" }

ruby "3.3.0"

gem "bcrypt"
gem "bootsnap", require: false
gem "code-ruby"
gem "dorian"
gem "dotenv-rails"
gem "faker"
gem "heroicon"
gem "importmap-rails"
gem "irb"
gem "jbuilder"
gem "mission_control-jobs"
gem "net-http"
gem "pandoc-ruby"
gem "pg"
gem "phonelib"
gem "puma"
gem "pundit"
gem "rack-attack"
gem "rails", rails: :rails
gem "redis"
gem "rubocop"
gem "slim-rails"
gem "solid_errors", github: "fractaledmind/solid_errors"
gem "solid_queue"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "zxcvbn-ruby", require: "zxcvbn"

group :production do
  gem "rack-timeout"
end

group :test do
  gem "capybara"
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "selenium-webdriver"
  gem "sinatra"
  gem "timecop"
  gem "webmock"
end
