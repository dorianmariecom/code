# frozen_string_literal: true

source "https://rubygems.org"

git_source(:dorian) { |name| "https://github.com/dorianmariecom/#{name}" }
git_source(:rails) { |name| "https://github.com/rails/#{name}" }
git_source(:hotwired) { |name| "https://github.com/hotwired/#{name}" }

ruby "3.3.4"

gem "bcrypt"
gem "brakeman"
gem "bundler-audit"
gem "code-ruby"
gem "dorian"
gem "dorian-arguments"
gem "dotenv-rails"
gem "faker"
gem "heroicon"
gem "importmap-rails", dorian: "importmap-rails" # https://github.com/rails/importmap-rails/pull/257, https://github.com/rails/importmap-rails/pull/256
gem "irb"
gem "jbuilder"
gem "kamal"
gem "kaminari"
gem "mission_control-jobs", rails: "mission_control-jobs" # https://github.com/rails/mission_control-jobs/pull/138#issuecomment-2269828646
gem "net-http"
gem "open-uri"
gem "optparse"
gem "pg"
gem "phonelib"
gem "propshaft"
gem "puma"
gem "pundit"
gem "rack-attack"
gem "rails", rails: :rails
gem "redis"
gem "rpush"
gem "rubocop"
gem "rubocop-factory_bot"
gem "rubocop-performance"
gem "rubocop-rails"
gem "rubocop-rake"
gem "rubocop-rspec"
gem "rubocop-rspec_rails"
gem "slim-rails"
gem "solid_errors", dorian: :solid_errors
gem "solid_queue"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails", hotwired: "turbo-rails"
gem "zxcvbn-ruby", require: "zxcvbn"

group :production do
  gem "rack-timeout"
end

group :development, :test do
  gem "capybara"
  gem "factory_bot_rails"
  gem "pry-rescue"
  gem "pry-stack_explorer"
  gem "rspec-rails"
  gem "selenium-webdriver"
  gem "sinatra"
  gem "timecop"
  gem "webmock"
end

gem "rubocop-capybara"
