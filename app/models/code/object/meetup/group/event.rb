# frozen_string_literal: true

class Code
  class Object
    class Meetup < Object
      class Group < Object
        class Event < Object
          attr_reader :raw, :title, :time, :group

          def initialize(title:, time:, group:)
            @raw = Dictionary.new(title:, time:, group:)
            @title = title
            @time = time
            @group = group
          end

          def self.name
            "Meetup::Group::Event"
          end

          def call(**args)
            operator = args.fetch(:operator, nil)

            case operator.to_s
            when "title"
              sig(args)
              code_title
            when "time"
              sig(args)
              code_time
            when "group"
              sig(args)
              code_group
            else
              super
            end
          end

          def code_time
            Time.new(time)
          end

          def code_title
            String.new(code_title)
          end

          def group
            Group.new(code_group)
          end

          def to_s
            raw.to_s
          end

          def inspect
            raw.inspect
          end
        end
      end
    end
  end
end
