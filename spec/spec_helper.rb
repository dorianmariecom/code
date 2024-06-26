# frozen_string_literal: true

require "webmock/rspec"
require "sinatra"
require "timecop"

Dir["spec/support/**/*.rb"].each do |filename|
  require_relative("../#{filename}")
end

Timecop.safe_mode = true

RSpec.configure do |config|
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.default_formatter = "doc" if config.files_to_run.one?
end
