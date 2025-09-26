FactoryBot.define do
  factory :workout_template do
    sequence(:name) { |n| "Template #{n}" }
    description { "A great workout template" }
  end
end
