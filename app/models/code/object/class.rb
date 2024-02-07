class Code
  class Object
    class Class < Object
      alias_method :original_call, :call

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value

        if raw == Email && operator.to_s == "send"
          sig(args)
          Class.new(Email)
        else
          original_call(**args)
        end
      end
    end
  end
end
