# frozen_string_literal: true

class Code
  class Object
    class Mail < Object
      DEFAULT_FROM = "Dorian Marié <dorian@codedorian.com>"

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
              reply_to: String.maybe,
              subject: String.maybe,
              body: String.maybe,
              text: String.maybe,
              html: String.maybe
            }
          end
          if arguments.any?
            code_send(
              from: value.code_get(String.new("from")),
              to: value.code_get(String.new("to")),
              reply_to: value.code_get(String.new("reply_to")),
              subject: value.code_get(String.new("subject")),
              body: value.code_get(String.new("body")),
              text: value.code_get(String.new("text")),
              html: value.code_get(String.new("html"))
            )
          else
            code_send
          end
        else
          super
        end
      end

      def self.code_send(
        from: nil,
        to: nil,
        reply_to: nil,
        subject: nil,
        body: nil,
        text: nil,
        html: nil
      )
        from ||= Nothing.new
        to ||= Nothing.new
        reply_to ||= Nothing.new
        subject ||= Nothing.new
        body ||= Nothing.new
        text ||= Nothing.new
        html ||= Nothing.new

        from =
          if from.truthy?
            from.raw
          elsif Current.smtp_account
            Current.smtp_account.email_address_with_name
          else
            DEFAULT_FROM
          end

        to =
          if to.truthy?
            to.raw
          elsif Current.smtp_account
            Current.smtp_account.email_address_with_name
          else
            Current.email_address!.email_address_with_name
          end

        from = ::Mail::AddressList.new(from)
        to = ::Mail::AddressList.new(to)

        subject = subject.raw || ""
        body = body.raw || ""
        reply_to = reply_to&.raw || ""
        text = text&.raw || ""
        html = html&.raw || ""

        from.addresses.each do |from_address|
          to.addresses.each do |to_address|
            from_smtp_account =
              Current.smtp_accounts.detect do |smtp_account|
                smtp_account.user_name == from_address.address
              end

            to_smtp_account =
              Current.smtp_accounts.detect do |smtp_account|
                smtp_account.user_name == to_address.address
              end

            to_email_address =
              Current.email_addresses.detect do |email_address|
                email_address.email_address == to_address.address
              end

            if from_smtp_account && (to_email_address || to_smtp_account)
              from_smtp_account.deliver!(
                from: from_address.to_s,
                to: to_address.to_s,
                reply_to:,
                subject:,
                body:,
                text:,
                html:
              )
            elsif to_email_address || to_smtp_account
              EmailAddressMailer
                .with(
                  from: from_address.to_s,
                  to: to_address.to_s,
                  reply_to:,
                  subject:,
                  body:,
                  text:,
                  html:
                )
                .code_mail
                .deliver_later
            end
          rescue ::Net::SMTPAuthenticationError
            raise Error, "Wrong SMTP username or SMTP password"
          end
        end

        Nothing.new
      end
    end
  end
end
