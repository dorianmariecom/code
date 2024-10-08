# frozen_string_literal: true

require "rails_helper"

RSpec.describe Code do
  before { Current.user = create(:user, :dorian) }

  it "sends an email" do
    expect_any_instance_of(SmtpAccount).to receive(:deliver!).once

    described_class.evaluate(<<~CODE)
      Mail.send(
        to: "dorian@dorianmarie.com",
        subject: "Hello",
        body: "What's up?"
      )
    CODE
  end

  it "can use reply_to" do
    expect_any_instance_of(SmtpAccount).to receive(:deliver!).once

    described_class.evaluate(<<~CODE)
      Mail.send(
        subject: "What did you do last week?",
        reply_to: "adrienicohen@gmail.com"
      )
    CODE
  end

  it "checks the weather" do
    Timecop.freeze("2024-02-13 11:52") { described_class.evaluate(<<~CODE) }
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

  it "sends reminders" do
    Timecop.freeze("2024-03-05 18:00:00 +0100") do
      described_class.evaluate(<<~CODE)
      Meetup::Group.new("paris_rb").events.each do |event|
        next if event.past?

        if event.time.before?(1.day.from_now)
          unless Storage.exists?(id: event.id, type: :one_day_reminder)
            Sms.send(body: "{event.group.name}: {event.title} in one day {event.url}")
            Storage.create!(id: event.id, type: :one_day_reminder)
          end
        end

        if event.time.before?(2.hours.from_now)
          unless Storage.exists?(id: event.id, type: :two_hours_reminder)
            Sms.send(body: "{event.group.name}: {event.title} in two hours {event.url}")
            Storage.create!(id: event.id, type: :two_hours_reminder)
          end
        end
      end
    CODE
    end
  end

  it "searches for posts on X" do
    described_class.evaluate(<<~CODE)
      X.search(query: "to:dorianmariecom", type: :recent).each do |post|
        next if Storage.exists?(id: post.id)
        Sms.send(body: "New mention: @{post.author.username}: {post.text}")
        Storage.create!(id: post.id)
      end
    CODE
  end

  it "searches for mentions on X" do
    described_class.evaluate(<<~CODE)
      X.mentions.each do |post|
        next if Storage.exists?(id: post.id)
        Sms.send(body: "New mention: @{post.author.username}: {post.text}")
        Storage.create!(id: post.id)
      end
    CODE
  end

  it "send a post on X" do
    described_class.evaluate(<<~CODE)
      X.send(body: :Hello)
    CODE
  end

  it "sends payment notifications", :pending do
    described_class.evaluate(<<~CODE)
      event = Stripe::Webhook.event

      if event.payment_intent&.succeeded?
        Sms.send(body: "You got paid {event.payment_intent.amount}")
      end
    CODE
  end

  it "sends slack messages" do
    described_class.evaluate(<<~CODE)
      Slack.send(body: "Who is leading the syncs?", channel: "#team-template")
      Slack.send(body: "Who is leading the syncs?")
      Slack.send
      Slack.send(team: "dorianmarie.com")
    CODE
  end

  it "send messages", :pending do
    described_class.evaluate(<<~CODE)
      Slack.send(body: "Who is leading the syncs?", channel: "#team-template")

      X.send(body: "What do you want to do this week?")

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

  it "sends twilio sms", :pending do
    described_class.evaluate(<<~CODE)
      Twilio.send(body: "What do you want to do this week?")
    CODE
  end

  it "sends vonage sms", :pending do
    described_class.evaluate(<<~CODE)
      Vonage.send(body: "What do you want to do this week?")
    CODE
  end
end
