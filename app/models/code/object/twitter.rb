# frozen_string_literal: true

class Code
  class Object
    class Twitter < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)

        case operator.to_s
        when "mentions"
          sig(args)
          code_mentions
        end
      end

      def self.code_mentions
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
