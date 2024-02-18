# frozen_string_literal: true

FactoryBot.define do
  factory :email_address do
    user
    primary { false }
    verified { true }
    email_address { Faker::Internet.email }

    trait :not_primary

    trait :primary do
      primary { true }
    end

    trait :verified

    trait :not_verified do
      verified { false }
    end

    trait :dorian_com do
      email_address { "dorian@dorianmarie.com" }
    end
  end
end
