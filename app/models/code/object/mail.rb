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
            from: value&.code_get(+"from"),
            to: value&.code_get(+"to"),
            subject: value&.code_get(+"subject"),
            body: value&.code_get(+"body")
          )
        else
          super
        end
      end

      def self.code_send(from: nil, to: nil, subject: nil, body: nil)
        from ||= Nothing.new
        to ||= Nothing.new
        subject ||= Nothing.new
        body ||= Nothing.new

        from =
          if from.truthy?
            from.raw
          else
            ::Current.primary_smtp_account!.email_address_with_name
          end

        to =
          if to.truthy?
            to.raw
          else
            ::Current.primary_smtp_account!.email_address_with_name
          end

        from = ::Mail::AddressList.new(from)
        to = ::Mail::AddressList.new(to)

        from.addresses.each do |from_address|
          to.addresses.each do |to_address|
            Current
              .smtp_accounts!
              .find_by!(user_name: from_address.address)
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
