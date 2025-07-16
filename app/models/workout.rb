class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_exercises
  has_many :exercises, through: :workout_exercises

  validates :name, presence: true

  def performed_at_formatted
    performed_at.strftime("%a %D %l:%M %p")
  end
end
