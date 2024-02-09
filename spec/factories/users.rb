FactoryBot.define do
  factory :user do
    time_zone { "UTC" }

    trait :dorian do
      after(:create) do |user|
        create(:email_address, :com, user: user)
        create(:email_address, :fr, user: user)
        create(:email_address, :gmail, user: user)
      end
    end
  end
end
