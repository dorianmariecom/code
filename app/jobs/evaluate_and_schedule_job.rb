# frozen_string_literal: true

class EvaluateAndScheduleJob < ApplicationJob
  queue_as :default

  def perform(program:)
    program.evaluate!
    program.schedule!
  end
end
