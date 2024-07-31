class Device < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validate { can!(:update, user) }

  before_validation { log_in(self.user ||= User.create!) }

  def to_s
    platform.presence || "device##{id}"
  end
end
