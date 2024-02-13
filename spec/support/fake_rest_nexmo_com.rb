class FakeRestNexmoCom < Sinatra::Base
  post '/sms/json' do
    content_type :json

    File.read("spec/files/rest.nexmo.com/sms/json")
  end
end

RSpec.configure do |config|
  config.before do
    stub_request(:any, /rest.nexmo.com/).to_rack(FakeRestNexmoCom)
  end
end
