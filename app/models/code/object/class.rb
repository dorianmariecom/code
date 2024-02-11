class Code
  class Object
    class Class < Object
      alias_method :original_call, :call

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        value = arguments.first&.value

        if raw == Mail && operator.to_s == "send"
          sig(args) do
            {
              from: String.maybe,
              to: String.maybe,
              subject: String.maybe,
              body: String.maybe
            }
          end
          Mail.code_send(
            from: value&.code_get(String.new("from")),
            to: value&.code_get(String.new("to")),
            subject: value&.code_get(String.new("subject")),
            body: value&.code_get(String.new("body"))
          )
        else
          original_call(**args)
        end
      end
    end
  end
end
