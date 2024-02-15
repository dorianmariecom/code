# frozen_string_literal: true

class Code
  class Object
    class Twitter < Object
      def self.name
        "Twitter"
      end

      def to_s
        "twitter"
      end

      def inspect
        to_s
      end
    end
  end
end
