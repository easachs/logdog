FactoryBot.define do
  factory :exercise do
    sequence(:name) { |n| "Exercise #{n}" }
    category { "Strength" }
    equipment { "Barbell" }
    description { "A great exercise for building strength" }
  end
end
