class TimeZone < ApplicationRecord
  TIME_ZONES =
    ActiveSupport::TimeZone.all.map(&:tzinfo).map(&:canonical_identifier)

  belongs_to :user, default: -> { Current.user }, touch: true

  scope :primary, -> { where(primary: true) }
  scope :not_primary, -> { where(primary: false) }
  scope :verified, -> { where(verified: true) }
  scope :not_verified, -> { where(verified: false) }

  validates :time_zone, inclusion: { in: TIME_ZONES, allow_blank: true }
  validate { can!(:update, user) }

  before_validation { self.user ||= User.create! }

  before_update { unverify! if time_zone_changed? && verified? }

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
    time_zone.presence || "time_zone##{id}"
  end
end
