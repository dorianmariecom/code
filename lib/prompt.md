# Documentation

## Hello World

input:

    "Hello World"

result:

    Hello World

---

## Printing Hello World

input:

    puts("Hello world")

output:

    Hello World

---

## Maths

input:

    1 + 1

result:

    2

---

## Integer#times

input:

    3.times { |i| puts(i) }

output:

    0
    1
    2

result:

    3

---

## Mail.send(from:, to:, subject:, body:)

**from**: The email address(es) you send from, e.g. "dominga\_nolan@hirthe.example", "Karly Hamill DDS <art\_balistreri@streich.example>", default: your primary email address

**to**: The email address(es) you send to, e.g. "david@labadie-reilly.test", "Fr. Nerissa Romaguera <elvin@feest.test>", default: your primary email address

**subject**: The subject of the email, e.g. "The Man Within", default: ""

**body**: The body of the email, e.g. "Re-contextualized contextually-based policy", default: ""

### Send an empty email to yourself

input:

    Mail.send

### Send a email to a list of persons

input:

    [
      "isidro_hackett@abernathy.test",
      "terence.prosacco@champlin.test",
      "ernie.schumm@ratke.example",
      "clarice@walsh.test",
      "jerald@hessel.test",
    ].each do |to|
      Mail.send(to: to, subject: "Hello")
    end

---

## Sms.send(body:)

**body**: The body of the text message, e.g. "A Many-Splendoured Thing", default: ""

### Send an empty SMS to yourself

input

    Sms.send

### Send an SMS to yourself

input

    Sms.send(body: "How are you?")

### Send an SMS when it's going to rain tomorrow in Paris, France

input

    if Weather.raining?(query: "Paris, France", date: Date.tomorrow)
      Sms.send(body: "It will be raining tomorrow")
    end

---

## Weather.raining?(query:, date:)

**query**: The location of the weather, e.g. "657 Kindra Extension, West Sheron, RI 31642", "-35.48643855535515,-10.863481369711963", default: Your location

**date**: The date of the weather, e.g. Date.tomorrow, Date.today, Date.yesterday, 1.hour.from_now, 1.hour.ago, 2.hours.from_now, 2.hours.ago, default: Date.now

### Check if it's raining

input

    Weather.raining?

output

    false

### Check if it's raining in Paris, France

input

    Weather.raining?(query: "Paris, France")

output

    false

### Check if it's raining in Paris, France tomorrow

input

    Weather.raining?(query: "Paris, France", date: Date.tomorrow)

output

    true

---

## Slack.send(team:, channel:, body:)

**team**: Your team ID or team name, e.g. "A00AA0AAAAA" or "Lockman LLC", default: Your primary slack account team

**channel**: The channel you want to send to, e.g. "#general", "#random", "#isaiah", default: "#general"

**body**: The body of the text message, e.g. "I Sing the Body Electric", default: ""

### Send an empty Slack message to #general in your primary slack account

input

    Slack.send

### Send a Slack message to the #general channel

input

    Slack.send(body: "Hello everybody")

### Send a slack message to #weather if it's going to be raining tomorrow

input

    if Weather.raining?(date: Date.tomorrow)
      Slack.send(body: "It's going to be raining tomorrow", channel: "#weather")
    else
      Slack.send(body: "It's not going to be raining tomorrow", channel: "#weather")
    end

## Meetup::Group.new(handle)

**handle**: Same as what's in the URL of the group on meetup.com, e.g. "paris_rb", :paris_rb, 'paris_rb'

input

    Meetup::Group.new(:paris_rb)

output

    paris_rb

## Meetup::Group#events

### Get the events from the meetup group paris_rb

input

    Meetup::Group.new("paris_rb").events

output

    ["Meetup::Event#297791280", "Meetup::Event#299466405", "Meetup::Event#297791270"]

### Send a reminder by SMS if meetups from the group ParisRb.new are going to happen in less than 1 day and in less than 2 hours

input

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

    nothing
