# frozen_string_literal: true

class Program < ApplicationRecord
  TIMEOUT = 1.second
  belongs_to :user, default: -> { Current.user || User.new }

  accepts_nested_attributes_for :user

  def evaluate!
    output = StringIO.new
    error = StringIO.new
    result =
      Current.with(user:) do
        Code.evaluate(input, output:, error:, timeout: TIMEOUT)
      end
    update!(result:, output: output.string, error: error.string)
  rescue Code::Error, Timeout::Error => e
    update!(result: "", output: "", error: "#{e.class}: #{e.message}")
  end

  def to_s
    name.presence || "Program##{id}"
  end
end
