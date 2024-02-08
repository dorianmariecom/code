class Code
  class Object
    class Email < Object
      def self.name
        "Email"
      end

      def self.code_send(from: nil, to: nil, subject: nil, body: nil)
        if from.nil? || from.falsy?
          from = Current.primary_email_address!
          from = from.email_address_with_display_name
        else
          from = from.raw
        end

        from = Mail::AddressList.new(from)
        p from

        #mail = Mail.new
        #mail.from = from
        #mail.to = to
        #mail.subject = subject.raw
        #mail.body = body.raw
        #mail.delivery_method(
        #  :smtp,
        #  address: address,
        #  port: port,
        #  user_name: user_name,
        #  password: password,
        #  authentication: authentication,
        #  enable_starttls_auto: enable_starttls_auto
        #)
        #mail.deliver!
        #Nothing.new
      end

      def to_s
        "email"
      end
    end
  end
end
