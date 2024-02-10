FactoryBot.define do
  factory :email_address do
    user
    primary { false }
    display_name { "Dorian Marié" }
    email_address { "dorian@dorianmarie.com" }
    smtp_user_name { email_address }
    smtp_password { "fake-password" }

    trait :com

    trait :fr do
      email_address { "dorian@dorianmarie.fr" }
    end

    trait :gmail do
      email_address { "dorian.marie.france@gmail.com" }
    end
  end
end
