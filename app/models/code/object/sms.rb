# frozen_string_literal: true

class Code
  class Object
    class Sms < Object
      MAX_FORECAST_DAYS = 14

      def self.name
        "Sms"
      end

      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value

        case operator.to_s
        when "send"
          sig(args) { { body: String.maybe } }
          code_send(body: value&.code_get(String.new("body")))
        else
          super
        end
      end

      def self.code_send(body: nil)
        body ||= Nothing.new

        from = "CodeDorian"
        to = Current.primary_phone_number!.phone_number
        body = body.truthy? ? body.raw : ""

        uri = URI.parse("https://rest.nexmo.com/sms/json")
        request = Net::HTTP::Post.new(uri)
        request.body = {
          from:,
          to:,
          text: body,
          api_key: Rails.application.credentials.rest_nexmo_com.api_key,
          api_secret: Rails.application.credentials.rest_nexmo_com.api_secret
        }.to_query

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        Nothing.new
      end
    end
  end
end
