FactoryBot.define do
  factory :workout_exercise do
    workout
    exercise
    order { 1 }
    notes { "Focus on form" }
  end
end
