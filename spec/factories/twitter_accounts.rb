# frozen_string_literal: true

FactoryBot.define do
  factory :twitter_account do
    user
    primary { false }
    verified { true }

    auth do
      {
        "scope":
          "aaaa.aaaaa aaaaa.aaaaaaaa.aaaaa aaaaa.aaaa aaaaaaa.aaaa aaaaaaa.aaaaaa " \
            "aaaa.aaaaa aaaaaaaa.aaaa aaaa.aaaa aaaaa.aaaaa aaaaa.aaaa aaaaa.aaaaa " \
            "aaaa.aaaaa aaaa.aaaa aaaaa.aaaa aaaaa.aaaa aaaaaaaa.aaaaa aaaa.aaaa " \
            "aaaaaaa.aaaaa",
        "expires_in": 0,
        "token_type": "aaaaaa",
        "access_token":
          "A0AAa0AAAAAaaAAAAA00AAAaAaAaAa0aAa0aAaa0A0AaaA0AAAAAAaAAAAAAA" \
            "aA0AAAaAAA0AAA0AAa0AAaaAaA0AaA",
        "refresh_token":
          "aA0aA00Aa0aaAaaAAA0aAa0AAaAaAAAaaaA0A0AaAAaAaAAaA0aAa0AAAAAAA" \
            "aA0AAAaAAA0AAA0AAa0AAaaAaA0AaA"
      }
    end

    me do
      {
        "id": "0000000000000000000",
        "url": "aaaaa://a.aa/AaAAaA0aaa",
        "name": "Aaaaaa Aaaaé",
        "entities": {
          "url": {
            "urls": [
              {
                "end": 0,
                "url": "aaaaa://a.aa/AaAAaA0aaa",
                "start": 0,
                "display_url": "aaaaaaaaaaa.aa",
                "expanded_url": "aaaaa://aaaaaaaaaaa.aa"
              }
            ]
          }
        },
        "location": "Aaaaa",
        "username": "aaaaaaaaaaaaaa",
        "verified": false,
        "protected": false,
        "created_at": "0000-00-00A00:00:00.000A",
        "description": "Aaaaaaaaaa. Aaaaaaaaaa aaaaaaaaaa, " \
          "Aaaaaaaa, Aaaaaaa, Aaaaaaa Aaaa",
        "public_metrics": {
          "like_count": 0,
          "tweet_count": 0,
          "listed_count": 0,
          "followers_count": 0,
          "following_count": 0
        },
        "profile_image_url":
          "aaaaa://aaa.aaaaa.aaa/aaaaaaa_aaaaaa/" \
            "0000000000000000000/0a0A_aaA_aaaaaa.aaa"
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
          scope:
            "mute.write tweet.moderate.write block.read follows.read " \
              "offline.access list.write bookmark.read list.read tweet.write " \
              "space.read block.write like.write like.read users.read tweet.read " \
              "bookmark.write mute.read follows.write",
          expires_in: 7200,
          token_type: :bearer,
          access_token:
            "A0AAa0AAAAAaaAAAAA00AAAaAaAaAa0aAa0aAaa0A0AaaA0AAAAAAaAAAAA" \
              "AAaA0AAAaAAA0AAA0AAa0AAaaAaA0AaA",
          refresh_token:
            "aA0aA00Aa0aaAaaAAA0aAa0AAaAaAAAaaaA0A0AaAAaAaAAaA0aAa0AAAAAA" \
              "AaA0AAAaAAA0AAA0AAa0AAaaAaA0AaA"
        }
      end
      me do
        {
          id: "1205730701703819264",
          url: "https://t.co/TdIMjZ6qep",
          name: "Dorian Marié",
          entities: {
            url: {
              urls: [
                {
                  end: 23,
                  url: "https://t.co/TdIMjZ6qep",
                  start: 0,
                  display_url: "dorianmarie.fr",
                  expanded_url: "https://dorianmarie.fr"
                }
              ]
            }
          },
          location: "Paris",
          username: "dorianmariecom",
          verified: false,
          protected: false,
          created_at: "2019-12-14T06:06:24.000Z",
          description:
            "Programmer. Previously thoughtbot, Doctolib, Trusted, Bespoke Post",
          public_metrics: {
            like_count: 4828,
            tweet_count: 4343,
            listed_count: 23,
            followers_count: 716,
            following_count: 721
          },
          profile_image_url:
            "https://pbs.twimg.com/profile_images/" \
              "1591116978101551104/5u9Y_gqS_normal.jpg"
        }
      end
    end
  end
end
