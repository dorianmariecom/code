# frozen_string_literal: true

class Code
  class Object
    class Meetup < Object
      def self.name
        "Meetup"
      end

      def to_s
        "meetup"
      end

      def inspect
        to_s
      end
    end
  end
end
