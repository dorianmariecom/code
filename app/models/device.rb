class Device < ApplicationRecord
  PLATFORMS = %w[ios android]

  belongs_to :user, default: -> { Current.user }

  validate { can!(:update, user) }
  validates :token, presence: true, uniqueness: { scope: :user_id }
  validates :platform, inclusion: { in: PLATFORMS }

  before_validation { log_in(self.user ||= User.create!) }

  def to_s
    platform.presence || "device##{id}"
  end
end
