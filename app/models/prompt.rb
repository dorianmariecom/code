# frozen_string_literal: true

class Prompt
  MODEL = "ft:gpt-3.5-turbo-1106:personal::96W3xV3h"

  DOCUMENTATION = File.read(Rails.root.join("lib/prompt.md"))

  SYSTEM_PROMPT = <<~PROMPT
    Generate a JSON object with two fields: name and input

    `name` is the name of the program

    `input` is the code generated from the prompt in the Code language

    #{DOCUMENTATION}
  PROMPT

  attr_reader :prompt, :name, :input

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
    @input = json_content&.dig("input") || ""
    @name = json_content&.dig("name") || ""
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
    "Bearer #{Rails.application.credentials.api_openai_com.api_key}"
  end

  def model
    MODEL
  end

  def body
    JSON.dump(
      model:,
      response_format:,
      messages: [
        { role: "system", content: SYSTEM_PROMPT },
        { role: "user", content: prompt }
      ]
    )
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
    json&.dig("choices")
  end

  def choice
    choices&.first
  end

  def message
    choice&.dig("message")
  end

  def content
    message&.dig("content") || ""
  end

  def json_content
    JSON.parse(content)
  end
end
