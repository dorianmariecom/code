# frozen_string_literal: true

FactoryBot.define do
  factory :time_zone do
    user { Current.user }
    time_zone { TimeZone::TIME_ZONES.sample }

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
      time_zone { "Europe/Paris" }
    end
  end
end
