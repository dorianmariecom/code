# frozen_string_literal: true

Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store
  config.active_storage.service = :local
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.active_job.verbose_enqueue_logs = true
  config.assets.quiet = true
  config.i18n.raise_on_missing_translations = true
  config.action_view.annotate_rendered_view_with_filenames = true
  config.action_controller.raise_on_missing_callback_actions = true
end
