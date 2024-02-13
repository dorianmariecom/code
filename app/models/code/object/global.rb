class Code
  class Object
    class Global < Object
      alias_method :original_call, :call

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value

        if operator.to_s == "Mail"
          sig(args)
          Class.new(Mail)
        elsif operator.to_s == "Weather"
          sig(args)
          Class.new(Weather)
        elsif operator.to_s == "Sms"
          sig(args)
          Class.new(Sms)
        else
          original_call(**args)
        end
      end
    end
  end
end
