class User < ApplicationRecord
  TIME_ZONES =
    ["UTC"] +
      ActiveSupport::TimeZone.all.map(&:tzinfo).map(&:canonical_identifier)

  has_many :email_addresses

  accepts_nested_attributes_for(
    :email_addresses,
    reject_if: :all_blank,
    allow_destroy: true
  )

  validates :time_zone, presence: true, inclusion: { in: TIME_ZONES }

  def to_s
    "User##{id}"
  end
end
