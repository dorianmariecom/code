# frozen_string_literal: true

class Code
  class Object
    class Stripe < Object
      def self.name
        "Stripe"
      end

      def to_s
        "stripe"
      end

      def inspect
        to_s
      end
    end
  end
end
