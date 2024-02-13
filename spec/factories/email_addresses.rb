FactoryBot.define do
  factory :email_address do
    user
    primary { false }
    verified { true }
    email_address { Faker::Internet.email }
    smtp_user_name { Faker::Internet.email }
    smtp_password { Faker::Internet.password }

    trait :not_primary

    trait :primary do
      primary { true }
    end

    trait :verified

    trait :not_verified do
      verified { false }
    end

    trait :dorian do
      display_name { "Dorian Marié" }
    end

    trait :dorian_com do
      dorian
      email_address { "dorian@dorianmarie.com" }
      smtp_user_name { email_address }
    end

    trait :dorian_fr do
      dorian
      email_address { "dorian@dorianmarie.fr" }
      smtp_user_name { email_address }
    end

    trait :dorian_gmail do
      dorian
      email_address { "dorian.marie.france@gmail.com" }
      smtp_user_name { email_address }
    end
  end
end
