class Program < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  def evaluate!
    output = StringIO.new
    error = StringIO.new
    result = Code.evaluate(input, output: output, error: error)
    update!(result: result, output: output.string, error: error.string)
  rescue Code::Error => error
    update!(error: "#{error.class}: #{error.message}")
  end

  def to_s
    "Program##{id}"
  end
end
