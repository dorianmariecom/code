# frozen_string_literal: true

class Code
  class Object
    class Global < Object
      alias original_call call

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value
        values = arguments.map(&:value)

        case operator.to_s
        when "Mail"
          sig(args) { Object.repeat }
          value ? Mail.new(*values) : Class.new(Mail)
        when "Weather"
          sig(args) { Object.repeat }
          value ? Weather.new(*values) : Class.new(Weather)
        when "Sms"
          sig(args) { Object.repeat }
          value ? Sms.new(*values) : Class.new(Sms)
        when "Meetup"
          sig(args) { Object.repeat }
          value ? Meetup.new(*values) : Class.new(Meetup)
        when "Twitter"
          sig(args) { Object.repeat }
          value ? Twitter.new(*values) : Class.new(Twitter)
        when "Slack"
          sig(args) { Object.repeat }
          value ? Slack.new(*values) : Class.new(Slack)
        when "Stripe"
          sig(args) { Object.repeat }
          value ? Stripe.new(*values) : Class.new(Stripe)
        when "Storage"
          sig(args) { Object.repeat }
          value ? Storage.new(*values) : Class.new(Storage)
        else
          original_call(**args)
        end
      end
    end
  end
end
