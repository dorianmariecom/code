FactoryBot.define do
  factory :phone_number do
    user
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
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
