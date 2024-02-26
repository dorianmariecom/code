# frozen_string_literal: true

class Code
  class Object
    class Meetup < Object
      class Group < Object
        attr_reader :raw

        def initialize(group)
          @raw = group
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
          else
            super
          end
        end

        def code_events
          List.new(
            page.css("a").select do |a|
              a["href"] =~ %r{https://www.meetup.com/#{raw}/events/[0-9]+/}
            end.select do |a|
              a.css("time").text.present?
            end.map do |a|
              Event.new(
                title: String.new(a.css(".ds-font-title-3").text),
                time: Time.new(a.css("time").text),
                group: self
              )
            end
          )
        end

        def page
          @page ||= Nokogiri::HTML(URI.open(url))
        end

        def url
          "https://www.meetup.com/#{raw}"
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
