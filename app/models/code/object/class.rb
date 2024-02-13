class Code
  class Object
    class Class < Object
      alias_method :original_call, :call

      def self.name
        "Class"
      end

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
        elsif raw == Weather && operator.to_s == "raining?"
          sig(args) { { query: String.maybe, date: Date.maybe } }
          Weather.code_raining?(
            query: value&.code_get(String.new("query")),
            date: value&.code_get(String.new("date")),
          )
        else
          original_call(**args)
        end
      end

      def name
        raw.name
      end

      def to_s
        raw.name
      end

      def inspect
        to_s
      end
    end
  end
end
