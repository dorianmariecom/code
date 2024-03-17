# frozen_string_literal: true

class Code
  class Object
    class Weather < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, List.new)
        value = arguments.code_first

        case operator.to_s
        when "raining?"
          sig(args) { { query: String.maybe, date: Date.maybe } }
          if arguments.any?
            code_raining?(
              query: value.code_get(String.new("query")),
              date: value.code_get(String.new("date"))
            )
          else
            code_raining?
          end
        else
          super
        end
      end

      def self.code_raining?(query: nil, date: nil)
        query ||= Nothing.new
        date ||= Nothing.new

        query =
          if query.truthy?
            query.raw
          else
            "#{Current.latitude},#{Current.longitude}"
          end

        date = date.truthy? ? date.raw : ::Date.current
        days = 14
        q = query
        uri = URI.parse("https://api.weatherapi.com/v1/forecast.json")
        request = Net::HTTP::Post.new(uri)
        request.set_form_data(key:, q:, days:)

        response =
          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request)
          end

        json = JSON.parse(response.body)

        days = json.dig("forecast", "forecastday")
        day = days.detect { |day| day["date"] == date.to_s }
        return Nothing.new if day.nil?

        Boolean.new(day.dig("day", "daily_will_it_rain") == 1)
      end

      def self.key
        Rails.application.credentials.api_weatherapi_com.api_key
      end
    end
  end
end
