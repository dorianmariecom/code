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
    "10 years",
  ]

  belongs_to :program

  validates :interval, inclusion: { in: INTERVALS }

  validate :user_owns_program

  def user_owns_program
    return if Current.admin?
    raise Pundit::NotAuthorizedError if Current.programs.where(id: program).none?
  end

  def to_s
    "#{starts_at}: #{interval}"
  end
end
