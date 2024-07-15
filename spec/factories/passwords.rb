# frozen_string_literal: true

FactoryBot.define do
  factory :password do
    user { Current.user }
    hint { Faker::Book.title }
    password { Faker::Internet.password }
  end
end
