class TimeZone < ApplicationRecord
  TIME_ZONES =
    ActiveSupport::TimeZone.all.map(&:tzinfo).map(&:canonical_identifier)

  belongs_to :user, default: -> { Current.user }

  validates :time_zone, inclusion: { in: TIME_ZONES, allow_blank: true }
  validate { can!(:update, user) }

  before_update do
    unverify! if time_zone_changed? && verified?
  end

  def unverify!
    update!(verified: false)
  end

  def to_s
    time_zone.presence || "time_zone##{id}"
  end
end
