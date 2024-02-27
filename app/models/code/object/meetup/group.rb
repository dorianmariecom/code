# frozen_string_literal: true

class Code
  class Object
    class Meetup < Object
      class Group < Object
        attr_reader :raw

        def initialize(group)
          group = group.raw if group.is_a?(Group)
          @raw = group.to_s
        end

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
            Group.new(value)
          else
            super
          end
        end

        def call(**args)
          operator = args.fetch(:operator, nil)

          case operator.to_s
          when "events"
            sig(args)
            code_events
          when "name"
            sig(args)
            code_name
          else
            super
          end
        end

        def code_events
          List.new(
            page
              .css("a")
              .select do |a|
                a["href"] =~ %r{https://www.meetup.com/#{slug}/events/[0-9]+/}
              end
              .select { |a| a.css("time").text.present? }
              .map do |a|
                Event.new(
                  id: Integer.new(a["href"].to_s.scan(/[0-9]+/).last),
                  title: String.new(a.css(".ds-font-title-3").text),
                  time: Time.new(a.css("time").text),
                  group: self
                )
              end
          )
        end

        def code_name
          String.new(page.css(".ds-font-title-1").text)
        end

        def page
          @page ||= Nokogiri.HTML(URI.open(url))
        end

        def url
          "https://www.meetup.com/#{slug}"
        end

        def slug
          raw
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
