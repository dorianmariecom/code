# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    time_zone { User::TIME_ZONES.sample }

    trait :dorian do
      name { "Dorian Marié" }
      time_zone { "Europe/Paris" }
      phone_numbers { [association(:phone_number, :dorian_fr)] }
      passwords { [association(:password)] }

      email_addresses do
        [
          association(:email_address, :dorian_com, primary: true),
          association(:email_address, :dorian_fr),
          association(:email_address, :dorian_gmail)
        ]
      end
    end
  end
end
