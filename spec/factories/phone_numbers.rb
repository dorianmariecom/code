# frozen_string_literal: true

FactoryBot.define do
  factory :phone_number do
    user
    phone_number do
      begin
        phone_number = Faker::PhoneNumber.phone_number_with_country_code
        phonelib = Phonelib.parse(phone_number)
      end until phonelib.valid? && phonelib.possible?
      phone_number
    end
    primary { false }
    verified { true }

    trait :not_primary

    trait :primary do
      primary { true }
    end

    trait :verified

    trait :not_verified do
      verified { false }
    end

    trait :dorian_fr do
      phone_number { "+33 7 67 23 95 73" }
    end
  end
end
