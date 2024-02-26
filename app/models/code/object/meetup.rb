# frozen_string_literal: true

require_relative "meetup/group"
require_relative "meetup/event"

class Code
  class Object
    class Meetup < Object
      def self.name
        "Meetup"
      end

      def self.call(**args)
        operator = args.fetch(:operator, nil)

        case operator.to_s
        when "Group"
          sig(args)
          Class.new(Group)
        else
          super
        end
      end
    end
  end
end
