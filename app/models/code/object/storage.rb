# frozen_string_literal: true

class Code
  class Object
    class Storage < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, List.new)
        value = arguments.code_first

        case operator.to_s
        when "exists?", "exist?"
          sig(args) { Object.maybe }
          code_exists?(value)
        when "create!"
          sig(args) { Object.maybe }
          code_create!(value)
        else
          super
        end
      end

      def self.code_exists?(value)
        Boolean.new(
          Current
            .data
            .where("data @> ?", value.to_json)
            .or(Current.data.where(data: value.as_json))
            .any?
        )
      end

      def self.code_create!(value)
        Current.data.create!(data: value.as_json)
        Nothing.new
      end
    end
  end
end
