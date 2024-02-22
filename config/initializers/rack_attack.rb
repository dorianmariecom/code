class Rack::Attack
  throttle('request/ip', limit: 300, period: 5.minutes) do |request|
    request.ip
  end

  throttle('logins/ip', limit: 5, period: 20.seconds) do |request|
    if request.path == '/session' && request.post?
      request.ip
    end
  end
end
