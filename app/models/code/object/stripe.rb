# frozen_string_literal: true

require_relative "stripe/webhook"

class Code
  class Object
    class Stripe < Object
      def self.name
        "Stripe"
      end

      def self.call(**args)
        operator = args.fetch(:operator, nil)

        case operator.to_s
        when "Webhook"
          sig(args)
          Class.new(Webhook)
        else
          super
        end
      end
    end
  end
end
