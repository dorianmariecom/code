# frozen_string_literal: true

class Code
  class Object
    class Sms < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, List.new)
        value = arguments.code_first

        case operator.to_s
        when "send"
          sig(args) { { body: String.maybe } }
          if arguments.any?
            code_send(body: value.code_get(String.new("body")))
          else
            code_send
          end
        else
          super
        end
      end

      def self.code_send(body: nil)
        body ||= Nothing.new

        from = "CodeDorian"
        to = Current.primary_phone_number!.phone_number
        text = body.truthy? ? body.raw : ""

        uri = URI.parse("https://rest.nexmo.com/sms/json")
        request = Net::HTTP::Post.new(uri)
        request.body = { from:, to:, text:, api_key:, api_secret: }.to_query

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        Nothing.new
      end

      def self.api_key
        Rails.application.credentials.rest_nexmo_com.api_key
      end

      def self.api_secret
        Rails.application.credentials.rest_nexmo_com.api_secret
      end
    end
  end
end
