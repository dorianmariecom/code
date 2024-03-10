# frozen_string_literal: true

require_relative "stripe/webhook"

class Code
  class Object
    class Stripe < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value
        values = arguments.map(&:value)

        case operator.to_s
        when "Webhook"
          sig(args) { Object.repeat }
          value ? Webhook.new(*values) : Class.new(Webhook)
        else
          super
        end
      end
    end
  end
end
