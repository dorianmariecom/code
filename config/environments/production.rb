# frozen_string_literal: true

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.require_master_key = true
  config.public_file_server.enabled = true
  config.assets.compile = false
  config.active_storage.service = :local
  config.assume_ssl = true
  config.force_ssl = true
  config.logger =
    ActiveSupport::Logger
      .new($stdout)
      .tap { |logger| logger.formatter = ::Logger::Formatter.new }
      .then { |logger| ActiveSupport::TaggedLogging.new(logger) }
  config.log_tags = [:request_id]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
end
