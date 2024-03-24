# frozen_string_literal: true

class Code
  class Object
    class Twitter < Object
      class User < Object
        def initialize(*args, **_kargs, &_block)
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
          end
        end

        def code_id
          Integer.new(raw.code_get(String.new(:id)))
        end

        def code_username
          String.new(raw.code_get(String.new(:username)))
        end

        def code_name
          String.new(raw.code_get(String.new(:name)))
        end
      end
    end
  end
end
