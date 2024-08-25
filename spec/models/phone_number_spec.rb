# frozen_string_literal: true

require "rails_helper"

RSpec.describe PhoneNumber do
  it "unverifies if the phone number changes" do
    phone_number =
      create(:phone_number, verified: true, phone_number: "+33 7 67 23 95 73")
    expect(phone_number).to be_verified
    phone_number.update!(phone_number: "+33 3 44 46 87 66")
    expect(phone_number).not_to be_verified
  end

  it "doesn't unverify if primary changes" do
    phone_number = create(:phone_number, verified: true, primary: false)
    expect(phone_number).to be_verified
    phone_number.update!(primary: true)
    expect(phone_number).to be_verified
  end
end
