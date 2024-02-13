class FakeApiWeatherapiCom < Sinatra::Base
  post '/v1/forecast.json' do
    content_type :json

    File.read("spec/files/api.weatherapi.com/v1/forecast.json")
  end
end

RSpec.configure do |config|
  config.before do
    stub_request(:any, /api.weatherapi.com/).to_rack(FakeApiWeatherapiCom)
  end
end
