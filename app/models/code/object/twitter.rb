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
        twitter_account = Current.primary_twitter_account!
        id = twitter_account.twitter_id
        access_token = twitter_account.access_token
        uri =
          URI.parse("https://api.twitter.com/2/users/#{id}/mentions?#{query}")
        request = Net::HTTP::Get.new(uri)
        request["Authorization"] = "Bearer #{access_token}"
        response =
          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request)
          end
        json = JSON.parse(response.body)

        json["data"] = json["data"].map do |tweet|
          tweet.tap do |tweet|
            tweet["author"] = json.dig("includes", "users").detect do |user|
              user["id"] == tweet["author_id"]
            end
          end
        end

        List.new(json["data"].map { |tweet| Tweet.new(tweet) })
      end

      def self.query
        {
          "tweet.fields" => tweet_fields.join(","),
          "expansions" => expansions.join(","),
          "user.fields" => user_fields.join(","),
          "media.fields" => media_fields.join(",")
        }.to_query
      end

      def self.tweet_fields
        %w[created_at text author_id]
      end

      def self.expansions
        %w[author_id attachments.media_keys]
      end

      def self.user_fields
        %w[name username profile_image_url]
      end

      def self.media_fields
        %w[url type media_key]
      end
    end
  end
end
