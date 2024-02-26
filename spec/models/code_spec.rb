# frozen_string_literal: true

require "rails_helper"

RSpec.describe Code, type: :model do
  it "sends an email" do
    Current.user = create(:user, :dorian)

    expect_any_instance_of(SmtpAccount).to receive(:deliver!)

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
          Sms.send(body: "It will be raining tomorrow in Paris, France")
        end

        if Weather.raining?(date: Date.tomorrow)
          Sms.send(body: "It will be raining tomorrow in your current location")
        end

        if Weather.raining?
          Sms.send(body: "It's raining today")
        end
      CODE
    end
  end

=begin
  it "sends reminders" do
    Current.user = create(:user, :dorian)

    Code.evaluate(<<~CODE)
      Meetup::Group.new("parisrb").events.each do |event|
        if event.time.before?(1.day.from_now)
          unless Storage.exists?(id: event.id, type: :one_day_reminder)
            Sms.send(body: "{event.group.name}: {event.name} in one day {event.url}")
            Storage.create!(id: event.id, type: :one_day_reminder)
          end
        end

        if event.time.before?(2.hours.from_now)
          unless Storage.exists?(id: event.id, type: :two_hours_reminder)
            Sms.send(body: "{event.group.name}: {event.name} in two hours {event.url}")
            Storage.create!(id: event.id, type: :two_hours_reminder)
          end
        end
      end
    CODE
  end

  it "searches for tweets" do
    Current.user = create(:user, :dorian)

    Code.evaluate(<<~CODE)
      Twitter.search(query: "to:dorianmariecom", type: :recent).each do |tweet|
        next if Storage.exists?(id: tweet.id)
        Sms.send(body: "New mention: {tweet.user.screen_name}: {tweet.text}")
        Storage.create!(id: tweet.id)
      end
    CODE
  end

  it "searches for mentions on Twitter" do
    Current.user = create(:user, :dorian)

    Code.evaluate(<<~CODE)
      Twitter.mentions.each do |tweet|
        next if Storage.exists?(id: tweet.id)
        Sms.send(body: "New mention: {tweet.user.screen_name}: {tweet.text}")
        Storage.create!(id: tweet.id)
      end
    CODE
  end

  it "sends payment notifications" do
    Current.user = create(:user, :dorian)

    Code.evaluate(<<~CODE)
      event = Stripe::Webhook.event

      if event.payment_intent&.succeeded?
        Sms.send(body: "You got paid {event.payment_intent.amount}")
      end
    CODE
  end
=end

  it "sends slack messages" do
    Current.user = create(:user, :dorian)

    Code.evaluate(<<~CODE)
      Slack.send(body: "Who is leading the syncs?", channel: "#team-template")
      Slack.send(body: "Who is leading the syncs?")
      Slack.send
      Slack.send(team: "dorianmarie.com")
    CODE
  end

=begin
  it "send messages" do
    Current.user = create(:user, :dorian)
    Code.evaluate(<<~CODE)
      Slack.send(body: "Who is leading the syncs?", channel: "#team-template")

      Twitter.send(body: "What do you want to do this week?")

      Discord.send("Who will be the game master this week?")

      Email.send(
        subject: "What did you do last week?",
        reply_to: "adrienicohen@gmail.com"
      )

      Email.send(
        subject: "What do you want to do this week?",
        reply_to: "adrienicohen@gmail.com"
      )
    CODE
  end
=end
end
