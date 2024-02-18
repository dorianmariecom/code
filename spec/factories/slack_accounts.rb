# frozen_string_literal: true

FactoryBot.define do
  factory :slack_account do
    user
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

    trait :dorianmariecom do
    end
  end
end
