# frozen_string_literal: true

class PhoneNumber < ApplicationRecord
  DEFAULT_COUNTRY_CODE = "FR"
  BRAND = "Code"
  VERIFICATION_CODE_REGEXP = /\A[0-9 ]+\z/

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

  def phonelib
    Phonelib.parse(phone_number)
  end

  def e164
    phonelib.e164
  end

  def formatted
    phonelib.international
  end

  def verification_code_sent?
    nexmo_request_id.present?
  end

  def send_verification_code!
    query = {
      api_key: Rails.application.credentials.nexmo.api_key,
      api_secret: Rails.application.credentials.nexmo.api_secret,
      number: e164,
      brand: BRAND
    }.to_query

    uri = URI.parse("https://api.nexmo.com/verify/json?#{query}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    update!(nexmo_request_id: json["request_id"]) if json["status"] == "0"
  end

  def verify!(verification_code)
    return if nexmo_request_id.blank?

    verification_code = verification_code.gsub(/\D/, "")
    return if verification_code.blank?

    query = {
      api_key: Rails.application.credentials.nexmo.api_key,
      api_secret: Rails.application.credentials.nexmo.api_secret,
      request_id: nexmo_request_id,
      code: verification_code
    }.to_query

    uri = URI.parse("https://api.nexmo.com/verify/check/json?#{query}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)

    if json["status"] == "0"
      update!(verified: true, nexmo_request_id: "")
    else
      update!(nexmo_request_id: "")
    end
  end

  def cancel_verification!
    return if nexmo_request_id.blank?

    query = {
      api_key: Rails.application.credentials.nexmo.api_key,
      api_secret: Rails.application.credentials.nexmo.api_secret,
      request_id: nexmo_request_id,
      cmd: :cancel
    }.to_query

    update!(nexmo_request_id: "")

    uri = URI.parse("https://api.nexmo.com/verify/control/json?#{query}")
    Net::HTTP.get_response(uri)
  end

  def valid_phone_number
    errors.add(:phone_number, :invalid) if phonelib.invalid?
    errors.add(:phone_number, :impossible) if phonelib.impossible?
  end

  def to_s
    formatted.presence || "PhoneNumber##{id}"
  end
end
