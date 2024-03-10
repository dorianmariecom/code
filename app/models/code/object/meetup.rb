# frozen_string_literal: true

require_relative "meetup/group"
require_relative "meetup/event"

class Code
  class Object
    class Meetup < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value
        values = arguments.map(&:value)

        case operator.to_s
        when "Group"
          sig(args)
          value ? Group.new(*values) : Class.new(Group)
        when "Event"
          sig(args)
          value ? Event.new(*values) : Class.new(Event)
        else
          super
        end
      end
    end
  end
end
