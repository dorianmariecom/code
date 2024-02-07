class Code
  class Object
    class Email < Object
      def self.name
        "Email"
      end

      def self.code_send(from: nil, to: nil, subject: nil, body: nil)
        p [from, to, subject, body]
      end

      def to_s
        "email"
      end
    end
  end
end
