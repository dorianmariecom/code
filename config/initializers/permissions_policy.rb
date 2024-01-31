# frozen_string_literal: true

Rails.application.config.permissions_policy do |policy|
  policy.camera :none
  policy.gyroscope :none
  policy.microphone :none
  policy.usb :none
  policy.fullscreen :none
  policy.payment :none
end
