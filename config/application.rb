# frozen_string_literal: true

require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

require_relative "../app/models/code"

class Code
  class Application < Rails::Application
    config.load_defaults 7.2
    config.autoload_lib(ignore: %w[assets tasks])
    config.active_job.queue_adapter = :solid_queue
    config.active_record.automatically_invert_plural_associations = true
    config.mission_control.jobs.show_console_help = false
    config.active_support.to_time_preserves_timezone = :zone
    config.exceptions_app = self.routes
  end
end
