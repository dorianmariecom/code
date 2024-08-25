# frozen_string_literal: true

require_relative "config/application"
require "rspec/core/rake_task"

Rails.application.load_tasks

RSpec::Core::RakeTask.new(:spec) { |task| task.verbose = false }
