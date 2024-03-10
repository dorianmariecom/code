# frozen_string_literal: true

class Code
  class Object
    class Meetup < Object
      class Event < Object
        def initialize(*args, **_kargs, &_block)
          @raw = Dictionary.new(args.first.presence || {})
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
          Integer.new(raw.code_get(String.new(:id)))
        end

        def code_time
          Time.new(raw.code_get(String.new(:time)))
        end

        def code_title
          String.new(raw.code_get(String.new(:title)))
        end

        def code_group
          Group.new(raw.code_get(String.new(:group)))
        end

        def code_url
          String.new(
            "https://www.meetup.com/#{code_group.code_slug}/events/#{code_id}"
          )
        end

        def code_past?
          code_time.code_past?
        end

        def code_future?
          code_time.code_future?
        end
      end
    end
  end
end
