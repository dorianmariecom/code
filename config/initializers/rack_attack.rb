class Rack::Attack
  throttle("request/ip", limit: 300, period: 5.minutes) { |request| request.ip }

  throttle("sessions/ip", limit: 5, period: 20.seconds) do |request|
    request.ip if request.path =~ /session/
  end

  throttle("verification_codes/ip", limit: 5, period: 20.seconds) do |request|
    request.ip if request.path =~ /verification_code/
  end
end
