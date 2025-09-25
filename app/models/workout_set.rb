# == Schema Information
#
# Table name: workout_sets
#
#  id                  :bigint           not null, primary key
#  set_number          :integer
#  reps                :integer
#  weight              :decimal
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  workout_exercise_id :bigint           not null
#
# Indexes
#
#  index_workout_sets_on_workout_exercise_id  (workout_exercise_id)
#
# Foreign Keys
#
#  fk_rails_...  (workout_exercise_id => workout_exercises.id)
#
class WorkoutSet < ApplicationRecord
  belongs_to :workout_exercise
end
