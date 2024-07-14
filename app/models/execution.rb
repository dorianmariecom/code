class Execution < ApplicationRecord
  belongs_to :program

  has_one :user, through: :program

  validate { can!(:update, program) }

  def to_s
    "execution##{id}"
  end
end
