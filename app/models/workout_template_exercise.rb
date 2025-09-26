# == Schema Information
#
# Table name: workout_template_exercises
#
#  id                  :bigint           not null, primary key
#  order               :integer          not null
#  notes               :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  exercise_id         :bigint           not null
#  workout_template_id :bigint           not null
#
# Indexes
#
#  index_workout_template_exercises_on_exercise_id          (exercise_id)
#  index_workout_template_exercises_on_workout_template_id   (workout_template_id)
#  index_workout_template_exercises_on_workout_template_id_and_order  (workout_template_id,order)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (workout_template_id => workout_templates.id)
#
class WorkoutTemplateExercise < ApplicationRecord
  belongs_to :workout_template
  belongs_to :exercise

  validates :exercise_id, presence: true
  validates :order, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
