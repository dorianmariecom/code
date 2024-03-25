# frozen_string_literal: true

class Program < ApplicationRecord
  TIMEOUT = 1.second
  belongs_to :user, default: -> { Current.user || User.new }

  accepts_nested_attributes_for :user

  def evaluate!
    Current.with(user:) do
      output = StringIO.new
      error = StringIO.new
      result = Code.evaluate(input, output:, error:, timeout: TIMEOUT)
      update!(
        result: result.to_s,
        output: output.string,
        error: error.string
      )
    end
  rescue Code::Error, Timeout::Error => e
    update!(result: "", output: "", error: "#{e.class}: #{e.message}")
  end

  def to_s
    name.presence || "program##{id}"
  end
end
