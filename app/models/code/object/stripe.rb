# frozen_string_literal: true

class Code
  class Object
    class Stripe < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, List.new)

        case operator.to_s
        when "Webhook"
          sig(args) { Object.repeat }
          arguments.any? ? Webhook.new(*arguments.raw) : Class.new(Webhook)
        else
          super
        end
      end
    end
  end
end
