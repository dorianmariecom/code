# frozen_string_literal: true

class FakeApiOpenaiCom < Sinatra::Base
  post "/v1/chat/completions" do
    content_type :json

    File.read("spec/files/api.openai.com/v1/chat/completions.json")
  end
end

RSpec.configure do |config|
  config.before do
    stub_request(:any, /api.openai.com/).to_rack(FakeApiOpenaiCom)
  end
end
