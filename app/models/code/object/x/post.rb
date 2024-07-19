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
          when "html"
            sig(args)
            code_html
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
          tweet ? String.new(tweet["text"]) : String.new(as_json["text"])
        end

        def code_html
          html = code_text.raw

          mentions.each do |mention|
            html.gsub!(
              /( |^)(@#{mention["username"]})( |$)/,
              '\1<a href="https://x.com/\2">\2</a>\3'
            )
          end

          annotations.each do |annotation|
            html.gsub!(
              /( |^)(#{annotation["normalized_text"]})( |$)/,
              '\1<a href="https://x.com/search?q=\2">\2</a>\3'
            )
          end

          urls.each do |url|
            html.gsub!(
              /( |^)(#{url["url"]})( |$)/,
              '\1<a href="' + url["expanded_url"] + '">' + url["expanded_url"] +
                '</a>\3'
            )
          end

          cashtags.each do |cashag|
            html.gsub!(
              /( |^)(\$#{cashtag["tag"]})( |$)/,
              '\1<a href="https://x.com/search?q=\2">\2</a>\3'
            )
          end

          hashtags.each do |hashtag|
            html.gsub!(
              /( |^)(\$#{hashtag["tag"]})( |$)/,
              '\1<a href="https://x.com/search?q=\2">\2</a>\3'
            )
          end

          photos.each do |photo|
            html += "<a href=\"#{url}\"><img src=\"#{photo["url"]}\" /></a>"
          end

          videos.each do |video|
            html +=
              "<a href=\"#{url}\"><img src=\"#{video["preview_image_url"]}\" /></a>"
          end

          String.new(html)
        end

        def code_created_at
          Time.new(raw.code_get(String.new(:created_at)))
        end

        def code_author
          author ? User.new(author) : Nothing.new
        end

        def code_url
          String.new(url)
        end

        def url
          "https://x.com/#{username}/status/#{id}"
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
          users.detect { |user| user["id"] == author_id }
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

        def entities
          as_json["entities"] || {}
        end

        def annotations
          entities["annotations"] || []
        end

        def mentions
          entities["mentions"] || []
        end

        def cashtags
          entities["cashtags"] || []
        end

        def hashtags
          entities["hashtags"] || []
        end

        def urls
          entities["urls"] || []
        end

        def tweets
          includes["tweets"] || []
        end

        def media
          includes["media"] || []
        end

        def users
          includes["users"] || []
        end

        def retweet
          tweets.detect { |tweet| tweet["id"] == retweet_id }
        end

        def tweet
          tweets.detect { |tweet| tweet["id"] == id }
        end

        def tweet_media
          urls
            .map do |url|
              media.detect { |media| media["media_key"] == url["media_key"] }
            end
            .compact
        end

        def photos
          tweet_media.select { |media| media["type"] == "photo" }
        end

        def videos
          tweet_media.select { |media| media["type"] == "video" }
        end
      end
    end
  end
end
