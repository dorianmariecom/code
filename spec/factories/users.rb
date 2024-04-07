# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    time_zone { User::TIME_ZONES.sample }

    trait :dorian do
      name { "Dorian Marié" }
      time_zone { "Europe/Paris" }
      phone_numbers { [association(:phone_number, :dorian_fr)] }
      email_addresses { [association(:email_address, :dorian_com)] }
      slack_accounts { [association(:slack_account, :dorianmariecom)] }
      x_accounts { [association(:x_account, :dorianmariecom)] }
      smtp_accounts { [association(:smtp_account, :dorian_com)] }
      passwords { [association(:password)] }
    end
  end
end
