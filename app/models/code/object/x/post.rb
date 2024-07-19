# frozen_string_literal: true

class Code
  class Object
    class X < Object
      class Post < Object
        def initialize(*args, **_kargs, &_block)
          @raw = Dictionary.new(Json.to_code(args.first.presence || {}))
        end

        def call(**args)
          operator = args.fetch(:operator, nil)

          case operator.to_s
          when "id"
            sig(args)
            code_id
          when "url"
            sig(args)
            code_url
          when "text"
            sig(args)
            code_text
          when "retweet"
            sig(args)
            code_retweet
          when "created_at"
            sig(args)
            code_created_at
          when "author"
            sig(args)
            code_author
          else
            super
          end
        end

        def code_id
          Integer.new(raw.code_get(String.new(:id)))
        end

        def code_text
          if tweet
            String.new(tweet["text"])
          else
            String.new(raw.code_get(String.new(:text)))
          end
        end

        def code_created_at
          Time.new(raw.code_get(String.new(:created_at)))
        end

        def code_author
          author ? User.new(author) : Nothing.new
        end

        def code_url
          String.new("https://x.com/#{username}/status/#{id}")
        end

        def username
          author&.dig("username") || ""
        end

        def id
          as_json["id"].to_s
        end

        def author_id
          as_json["author_id"].to_s
        end

        def json
          as_json["json"]
        end

        def includes
          json["includes"]
        end

        def author
          includes["users"].detect { |user| user["id"].to_s == author_id.to_s }
        end

        def retweet_id
          (as_json["referenced_tweets"] || [])
            .select { |tweet| tweet["type"] == "retweeted" }
            .map { |tweet| tweet["id"].to_s }
            .first
            .to_s
        end

        def code_retweet
          retweet ? Post.new(retweet.merge("json" => json)) : Nothing.new
        end

        def retweet
          includes["tweets"].detect do |tweet|
            tweet["id"].to_s == retweet_id.to_s
          end
        end

        def tweet
          includes["tweets"].detect { |tweet| tweet["id"].to_s == id.to_s }
        end
      end
    end
  end
end
