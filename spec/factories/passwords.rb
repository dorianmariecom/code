FactoryBot.define do
  factory :password do
    user

    hint { Faker::Book.title }
    password { Faker::Internet.password }
  end
end
