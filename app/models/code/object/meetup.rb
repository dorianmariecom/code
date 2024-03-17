# frozen_string_literal: true

require_relative "meetup/group"
require_relative "meetup/event"

class Code
  class Object
    class Meetup < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, List.new)

        case operator.to_s
        when "Group"
          sig(args)
          arguments.any? ? Group.new(*arguments.raw) : Class.new(Group)
        when "Event"
          sig(args)
          arguments.any? ? Event.new(*arguments.raw) : Class.new(Event)
        else
          super
        end
      end
    end
  end
end
