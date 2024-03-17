# frozen_string_literal: true

class Code
  class Object
    class Slack < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, List.new)
        value = arguments.code_first

        case operator.to_s
        when "send"
          sig(args) do
            { team: String.maybe, channel: String.maybe, body: String.maybe }
          end
          if arguments.any?
            code_send(
              team: value.code_get(String.new("team")),
              channel: value.code_get(String.new("channel")),
              body: value.code_get(String.new("body"))
            )
          else
            code_send
          end
        end
      end

      def self.code_send(team: nil, channel: nil, body: nil)
        team ||= Nothing.new
        channel ||= Nothing.new
        body ||= Nothing.new

        team = team.truthy? ? team.raw : Current.primary_slack_account!.team_id
        channel = channel.truthy? ? channel.raw : "#general"
        body = body.truthy? ? body.raw : ""

        access_token = Current.slack_accounts!.find_by_team!(team).access_token

        uri = URI.parse("https://slack.com/api/chat.postMessage")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        request["Authorization"] = "Bearer #{access_token}"
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
