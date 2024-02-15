# frozen_string_literal: true

class Code
  class Object
    class Mail < Object
      def self.name
        "Mail"
      end

      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value

        case operator.to_s
        when "send"
          sig(args) do
            {
              from: String.maybe,
              to: String.maybe,
              subject: String.maybe,
              body: String.maybe
            }
          end
          code_send(
            from: value&.code_get(String.new("from")),
            to: value&.code_get(String.new("to")),
            subject: value&.code_get(String.new("subject")),
            body: value&.code_get(String.new("body"))
          )
        else
          super
        end
      end

      def self.code_send(from: nil, to: nil, subject: nil, body: nil)
        if from.nil? || from.falsy?
          from = ::Current.primary_email_address!
          from = from.email_address_with_display_name
        else
          from = from.raw
        end

        if to.nil? || to.falsy?
          to = ::Current.primary_email_address!
          to = to.email_address_with_display_name
        else
          to = to.raw
        end

        from = ::Mail::AddressList.new(from)
        to = ::Mail::AddressList.new(to)

        from.addresses.each do |from_address|
          to.addresses.each do |to_address|
            Current
              .email_addresses!
              .find_by!(email_address: from_address.address)
              .deliver!(
                from: from_address,
                to: to_address,
                subject: subject&.raw || "",
                body: body&.raw || ""
              )
          rescue ::Net::SMTPAuthenticationError
            raise ::Code::Error, "Wrong SMTP username or SMTP password"
          end
        end

        Nothing.new
      end
    end
  end
end
