# frozen_string_literal: true

FactoryBot.define do
  factory :slack_account do
    user { Current.user }
    primary { false }
    verified { true }

    auth do
      {
        team: {
          id: "A00AA0AAAAA",
          name: Faker::Company.name
        },
        access_token:
          "xoxb-0000000000000-0000000000000-0a0aaAa0aa0aAAa0aAaAaAa0"
      }
    end

    conversations do
      {
        channels: [
          { id: "A00AAAAAAA0", name: "general" },
          { id: "A00AA0A0AAA", name: Faker::Internet.username },
          { id: "A00A0AAA0AA", name: "random" }
        ]
      }
    end

    trait :not_primary

    trait :primary do
      primary { true }
    end

    trait :verified

    trait :not_verified do
      verified { false }
    end

    trait :dorianmariecom do
      auth do
        {
          team: {
            id: "T06JT9MPCVC",
            name: "dorianmarie.com"
          },
          access_token:
            "xoxb-0000000000000-0000000000000-0a0aaAa0aa0aAAa0aAaAaAa0"
        }
      end

      conversations do
        {
          channels: [
            { id: "C06JKBVTPC7", name: "general" },
            { id: "C06JT9X3WRL", name: "code" },
            { id: "C06K2CAS6QL", name: "random" }
          ]
        }
      end
    end
  end
end
