require "rails_helper"

RSpec.describe Code, type: :model do
  it "sends an email" do
    Current.user = create(:user, :dorian)

    expect_any_instance_of(EmailAddress).to receive(:deliver!)

    Code.evaluate(<<~CODE)
      Mail.send(
        to: "dorian@dorianmarie.com",
        subject: "Hello",
        body: "What's up?"
      )
    CODE
  end

  it "checks the weather" do
    Timecop.freeze("2024-02-13 11:52") do
      Current.user = create(:user, :dorian)

      Code.evaluate(<<~CODE)
        if Weather.raining?(query: "Paris, France", date: Date.tomorrow)
          Sms.send("It will be raining tomorrow")
        end
      CODE
    end
  end

  it "sends reminders" do
    Current.user = create(:user, :dorian)

    Code.evaluate(<<~CODE)
    CODE
  end

  it "searches for tweets" do
    Current.user = create(:user, :dorian)

    Code.evaluate(<<~CODE)
    CODE
  end

  it "sends payment notifications" do
    Current.user = create(:user, :dorian)

    Code.evaluate(<<~CODE)
    CODE
  end

  it "send messages" do
    Current.user = create(:user, :dorian)

    Code.evaluate(<<~CODE)
    CODE
  end
end
