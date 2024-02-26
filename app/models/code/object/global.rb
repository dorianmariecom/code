# frozen_string_literal: true

class Code
  class Object
    class Global < Object
      alias original_call call

      def call(**args)
        operator = args.fetch(:operator, nil)

        case operator.to_s
        when "Mail"
          sig(args)
          Class.new(Mail)
        when "Weather"
          sig(args)
          Class.new(Weather)
        when "Sms"
          sig(args)
          Class.new(Sms)
        when "Meetup"
          sig(args)
          Class.new(Meetup)
        when "Twitter"
          sig(args)
          Class.new(Twitter)
        when "Slack"
          sig(args)
          Class.new(Slack)
        when "Stripe"
          sig(args)
          Class.new(Stripe)
        when "Storage"
          sig(args)
          Class.new(Storage)
        else
          original_call(**args)
        end
      end
    end
  end
end
