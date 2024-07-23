class Location < ApplicationRecord
  belongs_to :user, default: -> { Current.user }, touch: true

  scope :primary, -> { where(primary: true) }
  scope :not_primary, -> { where(primary: false) }
  scope :verified, -> { where(verified: true) }
  scope :not_verified, -> { where(verified: false) }

  validate { can!(:update, user) }

  before_validation { log_in(self.user ||= User.create!) }

  before_update { unverify! if location_changed? && verified? }

  def unverify!
    update!(verified: false)
  end

  def primary?
    !!primary
  end

  def not_primary?
    !primary?
  end

  def verified?
    !!verified
  end

  def not_verified?
    !verified?
  end

  def to_s
    location.presence || "location##{id}"
  end
end
