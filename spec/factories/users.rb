FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    time_zone { User::TIME_ZONES.sample }

    trait :dorian do
      name { "Dorian Marié" }
      time_zone { "Europe/Paris" }

      email_addresses do
        [
          association(:email_address, :com, primary: true),
          association(:email_address, :fr),
          association(:email_address, :gmail),
        ]
      end

      passwords { [association(:password)] }
    end
  end
end
