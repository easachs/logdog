FactoryBot.define do
  factory :workout do
    name { "Workout #1" }
    performed_at { Time.zone.parse('2025-07-15 12:00:00') }
    length { 60 }
    notes { "Notes" }
    user
  end
end
