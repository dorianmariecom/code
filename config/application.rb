# frozen_string_literal: true

require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

require_relative "../app/models/code"

class Code
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w[assets tasks])
    config.hosts << "localhost:3000"
    config.hosts << ENV.fetch("HOST")
    config.action_mailer.preview_paths << "#{Rails.root}/spec/mailers/previews"
  end
end
