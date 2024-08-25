# frozen_string_literal: true

class Schedule < ApplicationRecord
  INTERVALS = [
    "once",
    "1 second",
    "5 second",
    "10 second",
    "30 second",
    "1 minute",
    "5 minutes",
    "10 minutes",
    "30 minutes",
    "1 hour",
    "6 hours",
    "12 hours",
    "1 day",
    "2 days",
    "3 days",
    "4 days",
    "5 days",
    "6 days",
    "1 week",
    "2 weeks",
    "3 weeks",
    "4 weeks",
    "1 month",
    "2 months",
    "3 months",
    "4 months",
    "5 months",
    "6 months",
    "1 year",
    "2 years",
    "3 years",
    "4 years",
    "5 years",
    "10 years"
  ].freeze

  PER = {
    "second" => 1.second,
    "seconds" => 1.second,
    "minute" => 1.minute,
    "minutes" => 1.minute,
    "hour" => 1.hour,
    "hours" => 1.hour,
    "day" => 1.day,
    "days" => 1.day,
    "week" => 1.week,
    "weeks" => 1.week,
    "month" => 1.month,
    "months" => 1.month,
    "year" => 1.year,
    "years" => 1.year
  }.freeze

  belongs_to :program, touch: true

  has_one :user, through: :program

  validates :interval, inclusion: { in: INTERVALS }

  validate { can!(:update, program) }

  def once?
    interval == "once"
  end

  def duration
    return 0 if once?

    count, per = interval.split

    count.to_i * PER.fetch(per)
  end

  def next_at
    return starts_at if once?

    at = starts_at

    at += duration while at.past?

    at
  end

  def to_s
    "#{starts_at}: #{interval}"
  end
end
