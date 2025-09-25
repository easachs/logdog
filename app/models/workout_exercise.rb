# == Schema Information
#
# Table name: workout_exercises
#
#  id          :bigint           not null, primary key
#  notes       :text
#  order       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  workout_id  :bigint           not null
#  exercise_id :bigint           not null
#
# Indexes
#
#  index_workout_exercises_on_exercise_id  (exercise_id)
#  index_workout_exercises_on_workout_id   (workout_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (workout_id => workouts.id)
#
class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise
  has_many :workout_sets, dependent: :destroy
end
