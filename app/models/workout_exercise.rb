class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise
  has_many :workout_sets
end
