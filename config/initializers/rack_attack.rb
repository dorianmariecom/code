class Rack::Attack
  throttle("request/ip", limit: 300, period: 5.minutes) { |request| request.ip }

  throttle("logins/ip", limit: 5, period: 20.seconds) do |request|
    request.ip if request.path == "/session" && request.post?
  end
end
