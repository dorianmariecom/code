# frozen_string_literal: true

class Code
  class Object
    class Weather < Object
      MAX_FORECAST_DAYS = 14

      def self.name
        "Weather"
      end

      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value

        case operator.to_s
        when "raining?"
          sig(args) { { query: String.maybe, date: Date.maybe } }
          code_raining?(
            query: value&.code_get(String.new("query")),
            date: value&.code_get(String.new("date"))
          )
        else
          super
        end
      end

      def self.code_raining?(query: nil, date: nil)
        query =
          if query.nil? || query.falsy?
            "#{Current.latitude},#{Current.longitude}"
          else
            query.raw
          end

        date =
          if date.nil? || date.falsy?
            Date.current
          else
            date.raw
          end

        uri = URI.parse("https://api.weatherapi.com/v1/forecast.json")
        request = Net::HTTP::Post.new(uri)
        request.set_form_data(
          key: Rails.application.credentials.weather_api.api_key,
          q: query,
          days: MAX_FORECAST_DAYS
        )

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

      def to_s
        "weather"
      end
    end
  end
end
