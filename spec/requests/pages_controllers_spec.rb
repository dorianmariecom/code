# frozen_string_literal: true

require "rails_helper"

RSpec.describe PagesController do
  describe "GET /up" do
    it "works" do
      get up_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /" do
    it "works" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
