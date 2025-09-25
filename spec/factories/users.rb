FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }

    trait :with_omniauth do
      provider { "google_oauth2" }
      uid { "123456789" }
    end
  end
end
