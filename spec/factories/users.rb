FactoryBot.define do
  factory :user do
    time_zone { User::TIME_ZONES.sample }

    trait :dorian do
      name { "Dorian Marié" }

      after(:create) do |user|
        create(:email_address, :com, user: user, primary: true)
        create(:email_address, :fr, user: user)
        create(:email_address, :gmail, user: user)
      end
    end
  end
end
