class Execution < ApplicationRecord
  belongs_to :program, touch: true

  has_one :user, through: :program

  validate { can!(:update, program) }

  def to_s
    "execution##{id}"
  end
end
