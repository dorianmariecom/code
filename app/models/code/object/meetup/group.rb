# frozen_string_literal: true

class Code
  class Object
    class Meetup < Object
      class Group < Object
        def self.name
          "Meetup::Group"
        end

        def self.call(**args)
          operator = args.fetch(:operator, nil)
          arguments = args.fetch(:arguments, [])
          value = arguments.first&.value

          case operator.to_s
          when "new"
            sig(args) { String }
          else
            super
          end
        end
      end
    end
  end
end
