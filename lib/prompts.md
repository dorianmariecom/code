- prompt
  hello world
- name
  Hello World
- input
  "Hello World"

- prompt
  print hello world
- name
  Printing Hello World
- input
  puts("Hello world")

- prompt
  maths
- name
  Maths
- input
  2 \* 3 + 1 / 4

- prompt
  print 3 times hello world
- name
  Prints 3 times hello world
- input
  3.times { puts("Hello World") }

- prompt
  send an empty email to myself
- name
  Sends an empty email to yourself
- input
  Mail.send

- prompt
  send an email to a list of persons
- name
  Sends an email to a list of persons
- input
  [
  "isidro_hackett@abernathy.test",
  "terence.prosacco@champlin.test",
  "ernie.schumm@ratke.example",
  "clarice@walsh.test",
  "jerald@hessel.test",
  ].each do |to|
  Mail.send(to: to, subject: :Hi, body: "How are you?")
  end

- prompt
  send an sms to myself
- name
  Sends an SMS to yourself
- input
  Sms.send(body: :Hello)

- prompt
  send an sms if it's going to rain in paris tomorrow
- name
  Sends an SMS if it's going to rain in Paris tomorrow
- input
  if Weather.raining?(query: "Paris, France", date: Date.tomorrow)
  Sms.send(body: "It will be raining tomorrow")
  end

- prompt
  is it raining?
- name
  Checks if it's raining
- input
  Weather.raining?

- prompt
  is it raining in paris?
- name
  Checks if it's raining in Paris
- input
  Weather.raining?(query: "Paris, France")

- prompt
  will it be raining in paris tomorrow?
- name
  Checks if it's going to rain in Paris tomorrow
- input
  Weather.raining?(query: "Paris, France", date: Date.tomorrow)

- prompt
  send a slack message
- name
  Sends a Slack message
- input
  Slack.send(body: :Hello)

- prompt
  send a slack message if it's going to be raining tomorrow
- name
  Sends a Slack message if it's going to be raining tomorrow
- input
  if Weather.raining?(date: Date.tomorrow)
  Slack.send(body: "It's going to be raining tomorrow", channel: "#weather")
  else
  Slack.send(body: "It's not going to be raining tomorrow", channel: "#weather")
  end

- prompt
  remind me of meetup events
- name
  Sends a reminder by SMS if meetups from the group ParisRb.new are going to happen in less than 1 day and in less than 2 hours
- input
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
