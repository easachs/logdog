FactoryBot.define do
  factory :workout_template_exercise do
    workout_template
    exercise
    order { 1 }
    notes { "Template notes" }
  end
end
