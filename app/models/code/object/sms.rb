class Code
  class Object
    class Sms < Object
      MAX_FORECAST_DAYS = 14

      def self.name
        "Sms"
      end

      def self.code_send(body: nil)
        from = "Code"
        to = Current.primary_phone_number!.phone_number
        body = body&.raw || ""

        uri = URI.parse("https://rest.nexmo.com/sms/json")
        request = Net::HTTP::Post.new(uri)
        request.body = {
          from: from,
          to: to,
          text: body,
          api_key: Rails.application.credentials.nexmo.api_key,
          api_secret: Rails.application.credentials.nexmo.api_secret
        }.to_query

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        Nothing.new
      end

      def to_s
        "sms"
      end
    end
  end
end
