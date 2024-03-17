class Rack::Attack
  throttle("request/ip", limit: 300, period: 5.minutes) { |request| request.ip }

  throttle("sessions/ip", limit: 5, period: 20.seconds) do |request|
    request.ip if /session/.match?(request.path)
  end

  throttle("verification_codes/ip", limit: 5, period: 20.seconds) do |request|
    request.ip if /verification_code/.match?(request.path)
  end
end
