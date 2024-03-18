# frozen_string_literal: true

class Code
  class Object
    class Meetup < Object
      class Group < Object
        def initialize(raw = nil, ...)
          @raw = String.new(raw.to_s)
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
                a["href"] =~
                  %r{https://www.meetup.com/#{code_slug}/events/[0-9]+/}
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
          @page ||=
            Nokogiri.HTML(Net::HTTP.get_response(URI.parse(code_url.raw)).body)
        end

        def code_url
          String.new("https://www.meetup.com/#{code_slug}")
        end

        def code_slug
          String.new(raw)
        end
      end
    end
  end
end
