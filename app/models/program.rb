class Program < ApplicationRecord
  NO_PRIMARY_ADDRESS_FOUND_ERROR = "Code::Error: No primary email address found"

  belongs_to :user, default: -> { Current.user }

  accepts_nested_attributes_for :user

  def evaluate!
    output = StringIO.new
    error = StringIO.new
    result = Current.with(user: user) do
      Code.evaluate(input, output: output, error: error)
    end
    update!(result: result, output: output.string, error: error.string)
  rescue Code::Error => error
    update!(error: "#{error.class}: #{error.message}")
  end

  def no_primary_address_found?
    error == NO_PRIMARY_ADDRESS_FOUND_ERROR
  end

  def to_s
    name.presence || "Program##{id}"
  end
end
