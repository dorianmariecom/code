# frozen_string_literal: true

class Code
  class Object
    class Twitter < Object
      def self.name
        "Twitter"
      end

      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value

        case operator.to_s
        when "mentions"
          sig(args) { { user: (String | Integer | Decimal).maybe } }
          code_mentions(user: value&.code_get(String.new("user")))
        end
      end

      def self.code_mentions(user: nil)
        user ||= Nothing.new

        user_id = Current.primary_twitter_account!.twitter_user_id

        uri = URI.parse("https://api.twitter.com/2/users/#{user_id}/mentions")
        request = Net::HTTP::Get.new(uri)
        request["Authorization"] = "Bearer #{bearer_token}"
        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        Nothing.new
      end

      def self.bearer_token
        Rails.application.credentials.api_twitter_com.bearer_token
      end
    end
  end
end
