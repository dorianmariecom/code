# frozen_string_literal: true

class Code
  class Object
    class Global < Object
      alias_method :original_call, :call

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, List.new)

        case operator.to_s
        when "Mail"
          sig(args) { Object.repeat }
          arguments.any? ? Mail.new(*arguments.raw) : Class.new(Mail)
        when "Weather"
          sig(args) { Object.repeat }
          arguments.any? ? Weather.new(*arguments.raw) : Class.new(Weather)
        when "Sms"
          sig(args) { Object.repeat }
          arguments.any? ? Sms.new(*arguments.raw) : Class.new(Sms)
        when "Meetup"
          sig(args) { Object.repeat }
          arguments.any? ? Meetup.new(*arguments.raw) : Class.new(Meetup)
        when "X"
          sig(args) { Object.repeat }
          arguments.any? ? X.new(*arguments.raw) : Class.new(X)
        when "Slack"
          sig(args) { Object.repeat }
          arguments.any? ? Slack.new(*arguments.raw) : Class.new(Slack)
        when "Stripe"
          sig(args) { Object.repeat }
          arguments.any? ? Stripe.new(*arguments.raw) : Class.new(Stripe)
        when "Storage"
          sig(args) { Object.repeat }
          arguments.any? ? Storage.new(*arguments.raw) : Class.new(Storage)
        else
          original_call(**args)
        end
      end
    end
  end
end
