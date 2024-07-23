# frozen_string_literal: true

class Program < ApplicationRecord
  TIMEOUT = 5.second

  belongs_to :user, default: -> { Current.user }, touch: true

  has_many :executions, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :prompts, dependent: :destroy

  accepts_nested_attributes_for :schedules

  validate { can!(:update, user) }

  before_validation { log_in(self.user ||= User.create!) }

  def evaluate!
    Current.with(user:) do
      output = StringIO.new
      error = StringIO.new
      result = Code.evaluate(input, output:, error:, timeout: TIMEOUT)
      executions.create!(
        input:,
        result: result.to_s,
        output: output.string,
        error: error.string
      )
    rescue Code::Error, Timeout::Error => e
      executions.create!(
        input:,
        result: nil,
        output: nil,
        error: "#{e.class}: #{e.message}"
      )
    end
  end

  def next_at
    schedules.map(&:next_at).select(&:future?).min
  end

  def scheduled?
    scheduled_jobs.any?
  end

  def schedule!
    scheduled_jobs.destroy_all
    return unless next_at
    EvaluateAndScheduleJob.set(wait_until: next_at).perform_later(program: self)
  end

  def scheduled_jobs
    SolidQueue::Job.where(class_name: "EvaluateAndScheduleJob").where(
      "arguments::jsonb @> ?",
      { arguments: [{ program: { _aj_globalid: to_global_id } }] }.to_json
    )
  end

  def to_s
    prompt.presence || input.presence || "program##{id}"
  end
end
