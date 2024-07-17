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
          when "text"
            sig(args)
            code_text
          when "created_at"
            sig(args)
            code_created_at
          when "author"
            sig(args)
            code_author
          end
        end

        def code_id
          Integer.new(raw.code_get(String.new(:id)))
        end

        def code_text
          String.new(raw.code_get(String.new(:text)))
        end

        def code_created_at
          Time.new(raw.code_get(String.new(:created_at)))
        end

        def code_author
          User.new(
            raw.as_json["json"]["includes"]["users"].detect do |user|
              user["id"] == raw.as_json["author_id"]
            end
          )
        end
      end
    end
  end
end
