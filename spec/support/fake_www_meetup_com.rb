# frozen_string_literal: true

class FakeWwwMeetupCom < Sinatra::Base
  get "/:id" do
    File.read("spec/files/www.meetup.com/paris_rb/index.html")
  end
end

RSpec.configure do |config|
  config.before do
    stub_request(:any, /www.meetup.com/).to_rack(FakeWwwMeetupCom)
  end
end
