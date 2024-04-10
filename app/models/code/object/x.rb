# frozen_string_literal: true

class Code
  class Object
    class X < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, List.new)
        value = arguments.code_first

        case operator.to_s
        when "mentions"
          sig(args)
          code_mentions
        when "send"
          sig(args) { { body: String.maybe } }
          if arguments.any?
            code_send(body: value.code_get(String.new(:body)))
          else
            code_send
          end
        when "search"
          sig(args) { { query: String.maybe, type: String.maybe } }
          if arguments.any?
            code_search(query: value.code_get(String.new(:query)))
          else
            code_search
          end
        else
          super
        end
      end

      def self.code_send(body: nil)
        body ||= Nothing.new
        body = body.truthy? ? body.raw : ""
        x_account = Current.primary_x_account!.tap(&:refresh_auth!)
        access_token = x_account.access_token

        uri = URI.parse("https://api.twitter.com/2/tweets")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        request["Authorization"] = "Bearer #{access_token}"
        request.body = { text: body }.to_json

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        Nothing.new
      end

      def self.code_mentions
        x_account = Current.primary_x_account!.tap(&:refresh_auth!)
        id = x_account.twitter_id
        access_token = x_account.access_token
        query = twitter_query.to_query
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
            tweet["author"] = json
              .dig("includes", "users")
              .detect { |user| user["id"] == tweet["author_id"] }
          end
        end

        List.new(json["data"].map { |tweet| Post.new(tweet) })
      end

      def self.code_search(query: nil)
        query ||= Nothing.new

        query = query.truthy? ? query.raw : ""
        query = { query: }.merge(twitter_query).to_query

        x_account = Current.primary_x_account!.tap(&:refresh_auth!)
        access_token = x_account.access_token
        uri =
          URI.parse("https://api.twitter.com/2/tweets/search/recent?#{query}")
        request = Net::HTTP::Get.new(uri)
        request["Authorization"] = "Bearer #{access_token}"
        response =
          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request)
          end
        json = JSON.parse(response.body)

        json["data"] = json["data"].map do |tweet|
          tweet.tap do |tweet|
            tweet["author"] = json
              .dig("includes", "users")
              .detect { |user| user["id"] == tweet["author_id"] }
          end
        end

        List.new(json["data"].map { |tweet| Post.new(tweet) })
      end

      def self.twitter_query
        {
          "tweet.fields" => tweet_fields.join(","),
          "expansions" => expansions.join(","),
          "user.fields" => user_fields.join(","),
          "media.fields" => media_fields.join(",")
        }
      end

      def self.tweet_fields
        %w[created_at text author_id]
      end

      def self.expansions
        %w[author_id attachments.media_keys]
      end

      def self.user_fields
        %w[id name username location profile_image_url]
      end

      def self.media_fields
        %w[url type media_key]
      end
    end
  end
end
