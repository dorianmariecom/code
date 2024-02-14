class PhoneNumber < ApplicationRecord
  DEFAULT_COUNTRY_CODE = "FR"

  belongs_to :user, default: -> { Current.user }

  scope :primary, -> { where(primary: true) }
  scope :not_primary, -> { where(primary: false) }
  scope :verified, -> { where(verified: true) }
  scope :not_verified, -> { where(verified: false) }

  validate :valid_phone_number

  def valid_phone_number
    if !phonelib.valid?
      errors.add(:phone_number, :not_valid)
    end
    if !phonelib.possible?
      errors.add(:phone_number, :not_possible)
    end
  end

  def phonelib
    Phonelib.parse(phone_number)
  end

  def formatted_phone_number
    phonelib.international
  end

  def to_s
    formatted_phone_number.presence || "PhoneNumber##{id}"
  end
end
