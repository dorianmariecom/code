# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    trait :admin do
      admin { true }
    end

    trait :dorian do
      phone_numbers { [association(:phone_number, :dorian_fr)] }
      email_addresses { [association(:email_address, :dorian_com)] }
      slack_accounts { [association(:slack_account, :dorianmariecom)] }
      x_accounts { [association(:x_account, :dorianmariecom)] }
      smtp_accounts { [association(:smtp_account, :dorian_com)] }
      passwords { [association(:password)] }
      names { [association(:name, :dorian)] }
      time_zones { [association(:time_zone, :dorian_fr)] }
      locations { [association(:location, :dorian_fr)] }
    end
  end
end
