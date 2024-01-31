# frozen_string_literal: true

Rails.application.configure do
  config.content_security_policy { |policy| policy.default_src :self }
end
