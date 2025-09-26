FactoryBot.define do
  factory :workout_set do
    workout_exercise
    set_number { 1 }
    reps { 10 }
    weight { 135.5 }
  end
end
