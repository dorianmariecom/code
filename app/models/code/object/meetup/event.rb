# frozen_string_literal: true

class Code
  class Object
    class Meetup < Object
      class Event < Object
        attr_reader :raw, :id, :title, :time, :group

        def initialize(id:, title:, time:, group:)
          id = id.raw if id.is_a?(Integer)
          title = title.raw if title.is_a?(String)
          time = time.raw if time.is_a?(Time)
          group = group.raw if group.is_a?(Group)
          @id = Integer.new(id)
          @title = String.new(title)
          @time = Time.new(time)
          @group = Group.new(group)
        end

        def self.name
          "Meetup::Event"
        end

        def call(**args)
          operator = args.fetch(:operator, nil)

          case operator.to_s
          when "id"
            sig(args)
            code_id
          when "title"
            sig(args)
            code_title
          when "time"
            sig(args)
            code_time
          when "group"
            sig(args)
            code_group
          when "url"
            sig(args)
            code_url
          when "past?"
            sig(args)
            code_past?
          when "future?"
            sig(args)
            code_future?
          else
            super
          end
        end

        def code_id
          Integer.new(id)
        end

        def code_time
          Time.new(time)
        end

        def code_title
          String.new(title)
        end

        def code_group
          Group.new(group)
        end

        def code_url
          String.new("https://www.meetup.com/#{group.slug}/events/#{id}/")
        end

        def code_past?
          time.code_past?
        end

        def code_future?
          time.code_future?
        end

        def to_s
          "#{self.class.name}##{id}"
        end

        def inspect
          to_s.inspect
        end
      end
    end
  end
end
