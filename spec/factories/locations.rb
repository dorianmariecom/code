# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    user { Current.user }
    location { Faker::Address.full_address }
    city { Faker::Address.city }
    street_number { Faker::Address.building_number }
    route { Faker::Address.street_name }
    county { Faker::Address.state }
    state { Faker::Address.state }
    postal_code { Faker::Address.postcode }
    country { Faker::Address.country }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

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
      location { "49 rue de Grandvilliers, 60360 Crèvecɶur-le-Grand, France" }
      city { "Crèvecœur-le-Grand" }
      street_number { "49" }
      route { "Rue de Grandvilliers" }
      county { "Oise" }
      state { "Hauts-de-France" }
      postal_code { "60360" }
      country { "France" }
      latitude { "49.6089971" }
      longitude { "2.0719486" }
    end
  end
end
