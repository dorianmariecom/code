# frozen_string_literal: true

class FakeApiTwitterCom < Sinatra::Base
  post "/2/oauth2/token" do
    JSON.pretty_generate(FactoryBot.create(:x_account).auth)
  end

  get "/2/users/:id/mentions" do
    File.read("spec/files/api.twitter.com/2/users/1205730701703819264/mentions")
  end

  get "/2/tweets/search/recent" do
    File.read("spec/files/api.twitter.com/2/tweets/search/recent")
  end

  post '/2/tweets' do
    File.read("spec/files/api.twitter.com/2/tweets.json")
  end
end

RSpec.configure do |config|
  config.before do
    stub_request(:any, /api.twitter.com/).to_rack(FakeApiTwitterCom)
  end
end
