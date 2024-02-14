class PhoneNumber < ApplicationRecord
  DEFAULT_COUNTRY_CODE = "FR"

  belongs_to :user, default: -> { Current.user }

  scope :primary, -> { where(primary: true) }
  scope :not_primary, -> { where(primary: false) }
  scope :verified, -> { where(verified: true) }
  scope :not_verified, -> { where(verified: false) }

  normalizes(
    :phone_number,
    with: ->(phone_number) { Phonelib.parse(phone_number).e164 }
  )

  validate :valid_phone_number

  def valid_phone_number
    errors.add(:phone_number, :invalid) if phonelib.invalid?
    errors.add(:phone_number, :impossible) if phonelib.impossible?
  end

  def phonelib
    Phonelib.parse(phone_number)
  end

  def e164
    phonelib.e164
  end

  def formatted
    phonelib.international
  end

  def to_s
    formatted.presence || "PhoneNumber##{id}"
  end
end
