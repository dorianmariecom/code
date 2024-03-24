# frozen_string_literal: true

class FakeApiTwitterCom < Sinatra::Base
  get "/2/users/:id/mentions" do
    File.read("spec/files/api.twitter.com/2/users/1205730701703819264/mentions")
  end
end

RSpec.configure do |config|
  config.before do
    stub_request(:any, /api.twitter.com/).to_rack(FakeApiTwitterCom)
  end
end
