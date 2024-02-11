class Code
  class Object
    class Mail < Object
      def self.name
        "Mail"
      end

      def self.code_send(from: nil, to: nil, subject: nil, body: nil)
        if from.nil? || from.falsy?
          from = Current.primary_email_address!
          from = from.email_address_with_display_name
        else
          from = from.raw
        end

        if to.nil? || to.falsy?
          to = Current.primary_email_address!
          to = from.email_address_with_display_name
        else
          to = to.raw
        end

        from = ::Mail::AddressList.new(from)
        to = ::Mail::AddressList.new(to)

        from.addresses.each do |from_address|
          to.addresses.each do |to_address|
            Current
              .email_addresses
              .find_by!(email_address: from_address.address)
              .deliver!(
                from: from_address,
                to: to_address,
                subject: subject&.raw || "",
                body: body&.raw || ""
              )
          end
        end

        Nothing.new
      end

      def to_s
        "mail"
      end
    end
  end
end
