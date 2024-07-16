# frozen_string_literal: true

FactoryBot.define do
  factory :name do
    user { Current.user }
    name { Faker::Name.name }

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

    trait :dorian do
      name { "Dorian Marié" }
    end
  end
end
