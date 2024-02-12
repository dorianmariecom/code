class Prompt
  attr_reader :prompt, :name, :input

  DOCUMENTATION = <<~MARKDOWN
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

    **from**: The email address(es) you send from, e.g. "ezra@sanford.test", "Gov. Marcos Sanford <sung\_kerluke@ziemann-luettgen.example>", default: your primary email address

    **to**: The email address(es) you send to, e.g. "arvilla@cremin.example", "Kyle Hane <gricelda\_brown@wyman.example>", default: your primary email address

    **subject**: The subject of the email, e.g. "A Passage to India", default: ""

    **body**: The body of the email, e.g. "Exclusive composite model", default: ""

    ### Send an empty email to yourself

    input:

        Mail.send

    ### Send a email to a list of persons

    input:

        [
          "haywood@kuhic-mcglynn.example",
          "paris@quigley.example",
          "lemuel@runolfsson.test",
          "barry@batz.test",
          "suellen@mosciski.test",
        ].each do |to|
          Mail.send(to: to, subject: "Hello")
        end
  MARKDOWN

  def initialize(prompt)
    @prompt = prompt
    @name = nil
    @input = nil
  end

  def self.generate(prompt)
    new(prompt).generate
  end

  def generate
    request.content_type = content_type
    request["Authorization"] = authorization
    request.body = body
    @input = json_content["input"]
    @name = json_content["name"]
    self
  end

  def as_json(...)
    { name: name, input: input }.as_json(...)
  end

  def uri
    URI.parse("https://api.openai.com/v1/chat/completions")
  end

  def request
    @request ||= Net::HTTP::Post.new(uri)
  end

  def content_type
    "application/json"
  end

  def authorization
    "Bearer #{Rails.application.credentials.open_ai.api_key}"
  end

  def model
    "gpt-4-1106-preview"
  end

  def body
    JSON.dump(
      model: model,
      response_format: response_format,
      messages: [
        { role: "system", content: system_prompt },
        { role: "user", content: prompt }
      ]
    )
  end

  def system_prompt
    <<~PROMPT
      Generate a JSON object with two fields: input and name.

      "input" is the code generated from the prompt in the Code language

      "name" is the name of the program

      Here is some documentation about Code in markdown:

      #{DOCUMENTATION}
    PROMPT
  end

  def response_format
    { type: :json_object }
  end

  def response
    @response ||= Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

  def json
    JSON.parse(response.body)
  end

  def choices
    json["choices"]
  end

  def choice
    choices.first
  end

  def message
    choice["message"]
  end

  def content
    message["content"]
  end

  def json_content
    JSON.parse(content)
  end
end
