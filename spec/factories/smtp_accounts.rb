# frozen_string_literal: true

FactoryBot.define do
  factory :smtp_account do
    user { Current.user }
    primary { false }
    verified { true }
    address { "smtp.gmail.com" }
    port { 587 }
    display_name { Faker::Name.name }
    user_name { Faker::Internet.email }
    password { Faker::Internet.password }
    authentication { :plain }
    enable_starttls_auto { true }

    trait :not_primary

    trait :primary do
      primary { true }
    end

    trait :verified

    trait :not_verified do
      verified { false }
    end

    trait :dorian_com do
      display_name { "Dorian Marié" }
      user_name { "dorian@dorianmarie.com" }
    end
  end
end
