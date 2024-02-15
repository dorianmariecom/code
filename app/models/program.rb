# frozen_string_literal: true

class Program < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  accepts_nested_attributes_for :user

  def evaluate!
    output = StringIO.new
    error = StringIO.new
    result = Current.with(user:) { Code.evaluate(input, output:, error:) }
    update!(result:, output: output.string, error: error.string)
  rescue Code::Error => e
    update!(result: "", output: "", error: "#{e.class}: #{e.message}")
  end

  def to_s
    name.presence || "Program##{id}"
  end
end
