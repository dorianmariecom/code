require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "Dorian is valid" do
    users(:dorian).valid?
  end
end
