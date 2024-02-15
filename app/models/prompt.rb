# frozen_string_literal: true

class Prompt
  attr_reader :prompt, :name, :input

  DOCUMENTATION = File.read("lib/prompt.md")

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
    { name:, input: }.as_json(...)
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
      model:,
      response_format:,
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
    @response ||=
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
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
