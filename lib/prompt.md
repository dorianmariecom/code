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

**from**: The email address(es) you send from, e.g. "jeremy@koch.example", "Daryl Weimann <bruno@cummerata-streich.example>", default: your primary email address

**to**: The email address(es) you send to, e.g. "corrine\_marks@klocko.test", "Monroe Heathcote <andre@murazik-bartell.test>", default: your primary email address

**subject**: The subject of the email, e.g. "A Farewell to Arms", default: ""

**body**: The body of the email, e.g. "Ameliorated bandwidth-monitored moratorium", default: ""

### Send an empty email to yourself

input:

    Mail.send

### Send a email to a list of persons

input:

    [
      "emerita.okeefe@carter.test",
      "lavonna@reichel.example",
      "reginald.casper@hahn-lehner.test",
      "ivonne_leffler@denesik-mosciski.example",
      "victor@schamberger-stroman.example",
    ].each do |to|
      Mail.send(to: to, subject: "Hello")
    end

---

## Sms.send(body:)

**body**: The body of the text message, e.g. "I Will Fear No Evil", default: ""

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

**query**: The location of the weather, e.g. "5316 Champlin Key, East Eddie, MA 21777-1431", "-22.284798477041647,45.12454353961925", default: Your location

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

    true

### Check if it's raining in Paris, France tomorrow

input

    Weather.raining?(query: "Paris, France", date: Date.tomorrow)

output

    true

---

## Slack.send(team:, channel:, body:)

**team**: Your team ID or team name, e.g. "A00AA0AAAAA" or "Schmeler, Wunsch and Zemlak", default: Your primary slack account team

**channel**: The channel you want to send to, e.g. "#general", "#random", "#carol_turner", default: "#general"

**body**: The body of the text message, e.g. "Fear and Trembling", default: ""

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
