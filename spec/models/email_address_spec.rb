require "rails_helper"

RSpec.describe EmailAddress do
  it "unverifies if the email address changes" do
    email_address =
      create(:email_address, verified: true, email_address: "a@a.a")
    expect(email_address).to be_verified
    email_address.update!(email_address: "b@b.b")
    expect(email_address).to_not be_verified
  end

  it "doesn't unverify if primary changes" do
    email_address = create(:email_address, verified: true, primary: false)
    expect(email_address).to be_verified
    email_address.update!(primary: true)
    expect(email_address).to be_verified
  end
end
