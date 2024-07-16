class Prompt < ApplicationRecord
  MODEL = "ft:gpt-3.5-turbo-1106:personal::9kRALHnW"

  DOCUMENTATION = File.read(Rails.root.join("lib/prompt.md"))

  SYSTEM_PROMPT = <<~PROMPT
    Generate a JSON object with one field: input

    `input` is the code generated from the prompt in the Code language

    #{DOCUMENTATION}
  PROMPT

  belongs_to :user, optional: true, default: -> { Current.user }
  belongs_to :program, optional: true

  validate { can!(:update, user) if user }
  validate { can!(:update, program) if program }

  def generate!
    uri = URI.parse("https://api.openai.com/v1/chat/completions")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = authorization
    request.body = body
    response =
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
    content = JSON.parse(response.body).dig("choices", 0, "message", "content")
    update!(input: JSON.parse(content).fetch("input"))
  end

  def authorization
    "Bearer #{Rails.application.credentials.api_openai_com.api_key}"
  end

  def body
    JSON.dump(
      model: MODEL,
      response_format: {
        type: :json_object
      },
      messages: [
        { role: "system", content: SYSTEM_PROMPT },
        { role: "user", content: prompt }
      ]
    )
  end

  def to_s
    prompt.presence || input.presence || "prompt##{id}"
  end
end
