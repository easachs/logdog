FactoryBot.define do
  factory :weightlog do
    user
    weight { 180.5 }
    logged_at { Time.current }
  end
end
