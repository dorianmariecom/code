# frozen_string_literal: true

class Code
  class Object
    class Slack < Object
      def self.name
        "Slack"
      end

      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value

        case operator.to_s
        when "send"
          sig(args) { { channel: String.maybe, body: String.maybe } }
          code_send(
            channel: value&.code_get(String.new("channel")),
            body: value&.code_get(String.new("body"))
          )
        end
      end

      def self.token
        Rails.application.credentials.slack.com.token
      end

      def self.code_send(channel: nil, body: nil)
        channel ||= Nothing.new
        body ||= Nothing.new

        channel =
          if channel.truthy?
            channel.raw
          else
            Current.primary_slack_account!.primary_channel!.slack_id
          end

        body = body.truthy? ? body.raw : ""

        uri = URI.parse("https://slack.com/api/chat.postMessage")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        request["Authorization"] = "Bearer #{token}"
        request.body =
          JSON.dump(
            {
              "channel" => channel,
              "blocks" => [
                {
                  "type" => "section",
                  "text" => {
                    "type" => "mrkdwn",
                    "text" => body
                  }
                }
              ]
            }
          )

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        Nothing.new
      end
    end
  end
end
