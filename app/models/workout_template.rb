# == Schema Information
#
# Table name: workout_templates
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class WorkoutTemplate < ApplicationRecord
  has_many :workout_template_exercises, dependent: :destroy
  has_many :exercises, through: :workout_template_exercises

  validates :name, presence: true

  def build_workout_for(user)
    workout = user.workouts.create!(
      name: "#{name} - #{Date.current.strftime('%B %d, %Y')}",
      performed_at: Time.current
    )

    workout_template_exercises.order(:order).each do |template_exercise|
      workout.workout_exercises.create!(
        exercise: template_exercise.exercise,
        order: template_exercise.order,
        notes: template_exercise.notes
      )
    end

    workout
  end
end
