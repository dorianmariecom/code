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
        x_account = Current.x_account!.tap(&:refresh_auth!)
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
        x_account = Current.x_account!.tap(&:refresh_auth!)
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
        return List.new if json.blank? || json["data"].blank?
        original_json = json.dup
        json["data"] = json["data"].map do |data|
          data.merge("json" => original_json)
        end
        List.new(json["data"].map { |tweet| Post.new(tweet) })
      end

      def self.code_search(query: nil)
        query ||= Nothing.new

        query = query.truthy? ? query.raw : ""
        query = { query: }.merge(twitter_query).to_query

        x_account = Current.x_account!.tap(&:refresh_auth!)
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
        return List.new if json.blank? || json["data"].blank?
        original_json = json.dup
        json["data"] = json["data"].map do |data|
          data.merge("json" => original_json)
        end
        List.new(json["data"].map { |tweet| Post.new(tweet) })
      end

      def self.twitter_query
        {
          "expansions" => expansions.join(","),
          "media.fields" => media_fields.join(","),
          "place.fields" => place_fields.join(","),
          "poll.fields" => poll_fields.join(","),
          "tweet.fields" => tweet_fields.join(","),
          "user.fields" => user_fields.join(",")
        }
      end

      def self.tweet_fields
        %w[
          attachments
          author_id
          context_annotations
          conversation_id
          created_at
          edit_controls
          edit_history_tweet_ids
          entities
          geo
          id
          in_reply_to_user_id
          lang
          possibly_sensitive
          public_metrics
          referenced_tweets
          reply_settings
          source
          text
          withheld
        ]
      end

      def self.expansions
        %w[
          attachments.media_keys
          attachments.poll_ids
          author_id
          entities.mentions.username
          geo.place_id
          in_reply_to_user_id
          referenced_tweets.id
          referenced_tweets.id.author_id
        ]
      end

      def self.user_fields
        %w[
          created_at
          description
          entities
          id
          location
          name
          pinned_tweet_id
          profile_image_url
          protected
          public_metrics
          url
          username
          verified
          withheld
        ]
      end

      def self.media_fields
        %w[
          duration_ms
          height
          media_key
          non_public_metrics
          organic_metrics
          preview_image_url
          promoted_metrics
          public_metrics
          type
          url
          width
        ]
      end

      def self.place_fields
        %w[
          contained_within
          country
          country_code
          full_name
          geo
          id
          name
          place_type
        ]
      end

      def self.poll_fields
        %w[duration_minutes end_datetime id options voting_status]
      end
    end
  end
end
