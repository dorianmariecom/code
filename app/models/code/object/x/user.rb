# frozen_string_literal: true

class Code
  class Object
    class X < Object
      class User < Object
        def initialize(*args, **_kargs, &)
          @raw = Dictionary.new(Json.to_code(args.first.presence || {}))
        end

        def call(**args)
          operator = args.fetch(:operator, nil)

          case operator.to_s
          when "username"
            sig(args)
            code_username
          when "id"
            sig(args)
            code_id
          when "name"
            sig(args)
            code_name
          when "url"
            sig(args)
            code_url
          else
            super
          end
        end

        def code_id
          Integer.new(raw.code_get(String.new(:id)))
        end

        def id
          code_id.to_s
        end

        def code_username
          String.new(raw.code_get(String.new(:username)))
        end

        def username
          code_username.to_s
        end

        def code_name
          String.new(raw.code_get(String.new(:name)))
        end

        def name
          code_name.to_s
        end

        def code_url
          +"https://x.com/#{username}"
        end

        def url
          code_url.to_s
        end
      end
    end
  end
end
