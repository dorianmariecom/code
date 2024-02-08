require "test_helper"

class CodeTest < ActiveSupport::TestCase
  test "sends an email" do
    Current.user = users(:dorian)

    assert_nothing_raised do
      Code.evaluate(<<~CODE)
        Email.send(
          to: "dorian@dorianmarie.fr",
          subject: "Hello",
          body: "What's up?"
        )
      CODE
    end
  end
end

