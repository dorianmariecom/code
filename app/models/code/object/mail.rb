# frozen_string_literal: true

class Code
  class Object
    class Mail < Object
      def self.call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, List.new)
        value = arguments.code_first

        case operator.to_s
        when "send"
          sig(args) do
            {
              from: String.maybe,
              to: String.maybe,
              subject: String.maybe,
              body: String.maybe,
              reply_to: String.maybe
            }
          end
          if arguments.any?
            code_send(
              from: value.code_get(String.new("from")),
              to: value.code_get(String.new("to")),
              subject: value.code_get(String.new("subject")),
              body: value.code_get(String.new("body")),
              reply_to: value.code_get(String.new("reply_to"))
            )
          else
            code_send
          end
        else
          super
        end
      end

      def self.code_send(from: nil, to: nil, subject: nil, body: nil, reply_to: nil)
        from ||= Nothing.new
        to ||= Nothing.new
        subject ||= Nothing.new
        body ||= Nothing.new
        reply_to ||= Nothing.new

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
            smtp_accounts = Current.smtp_accounts!
            smtp_account =
              smtp_accounts.find_by(user_name: from_address.address)
            smtp_account ||= Current.primary_smtp_account!
            smtp_account.deliver!(
              from: from_address,
              to: to_address,
              subject: subject&.raw || "",
              body: body&.raw || "",
              reply_to: reply_to&.raw || ""
            )
          rescue ::Net::SMTPAuthenticationError
            raise Error, "Wrong SMTP username or SMTP password"
          end
        end

        Nothing.new
      end
    end
  end
end
