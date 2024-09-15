# frozen_string_literal: true

class FakeSlackCom < Sinatra::Base
  post "/api/chat.postMessage" do
    content_type :json

    File.read("spec/files/slack.com/api/chat.postMessage.json")
  end
end

RSpec.configure do |config|
  config.before { stub_request(:any, /slack.com/).to_rack(FakeSlackCom) }
end
