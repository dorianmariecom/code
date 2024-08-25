# frozen_string_literal: true

require "rails_helper"

RSpec.describe SmtpAccount do
  it "unverifies if the address changes" do
    smtp_account =
      create(:smtp_account, verified: true, address: "smtp.gmail.com")
    expect(smtp_account).to be_verified
    smtp_account.update!(address: "smtp.mailchimp.com")
    expect(smtp_account).not_to be_verified
  end

  it "unverifies if the port changes" do
    smtp_account = create(:smtp_account, verified: true, port: 465)
    expect(smtp_account).to be_verified
    smtp_account.update!(port: 587)
    expect(smtp_account).not_to be_verified
  end

  it "unverifies if the user_name changes" do
    smtp_account =
      create(:smtp_account, verified: true, user_name: "old-user-name")
    expect(smtp_account).to be_verified
    smtp_account.update!(user_name: "new-user-name")
    expect(smtp_account).not_to be_verified
  end

  it "unverifies if the password changes" do
    smtp_account =
      create(:smtp_account, verified: true, password: "old-password")
    expect(smtp_account).to be_verified
    smtp_account.update!(password: "new-password")
    expect(smtp_account).not_to be_verified
  end

  it "unverifies if the authentication changes" do
    smtp_account = create(:smtp_account, verified: true, authentication: :plain)
    expect(smtp_account).to be_verified
    smtp_account.update!(authentication: :login)
    expect(smtp_account).not_to be_verified
  end

  it "unverifies if the enable_starttls_auto changes" do
    smtp_account =
      create(:smtp_account, verified: true, enable_starttls_auto: true)
    expect(smtp_account).to be_verified
    smtp_account.update!(enable_starttls_auto: false)
    expect(smtp_account).not_to be_verified
  end

  it "doesn't unverify if primary changes" do
    smtp_account = create(:smtp_account, verified: true, primary: false)
    expect(smtp_account).to be_verified
    smtp_account.update!(primary: true)
    expect(smtp_account).to be_verified
  end
end
