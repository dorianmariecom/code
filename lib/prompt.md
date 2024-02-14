Hello World
-----------

input:

    "Hello World"

result:

    Hello World

* * *

Printing Hello World
--------------------

input:

    puts("Hello world")

output:

    Hello World

* * *

Maths
-----

input:

    1 + 1

result:

    2

* * *

Integer#times
-------------

input:

    3.times { |i| puts(i) }

output:

    0
    1
    2

result:

    3

* * *

Mail.send(from:, to:, subject:, body:)
--------------------------------------

**from**: The email address(es) you send from, e.g. "bryan.ankunding@morissette-stracke.example", "Kellee Haag <fredric@johnston.example>", default: your primary email address

**to**: The email address(es) you send to, e.g. "tamika@hirthe.test", "Clyde Weber <bonita@runolfsson-kuhlman.example>", default: your primary email address

**subject**: The subject of the email, e.g. "Vile Bodies", default: ""

**body**: The body of the email, e.g. "Intuitive cohesive concept", default: ""

### Send an empty email to yourself

input:

    Mail.send

### Send a email to a list of persons

input:

    [
      "leon@gleason.test",
      "noah_thiel@balistreri-abbott.test",
      "elisa@feest.test",
      "keith.gusikowski@ondricka.test",
      "orville@fay.example",
    ].each do |to|
      Mail.send(to: to, subject: "Hello")
    end

* * *

Sms.send(body:)
---------------

**body**: The body of the text message, e.g. "Rosemary Sutcliff", default: ""

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

* * *

Weather.raining?(query:, date:)
-------------------------------

**query**: The location of the weather, e.g. "506 Bo Lock, Port Rosia, AK 66769", "42.01656369618982,49.2699455956712", default: Your location

**date**: The date of the weather, e.g. Date.tomorrow, Date.today, Date.yesterday, 1.hour.from\_now, 1.hour.ago, 2.hours.from\_now, 2.hours.ago, default: Date.now

### Check if it's raining

input

    Weather.raining?

output

    true

### Check if it's raining in Paris, France

input

    Weather.raining?(query: "Paris, France")

output

    true

### Check if it's raining in Paris, France tomorrow

input

    Weather.raining?(query: "Paris, France", date: Date.tomorrow)

output

    false
