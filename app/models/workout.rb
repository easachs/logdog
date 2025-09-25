# == Schema Information
#
# Table name: workouts
#
#  id           :bigint           not null, primary key
#  name         :string
#  notes        :text
#  performed_at :datetime
#  length       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_workouts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_exercises, dependent: :destroy
  has_many :exercises, through: :workout_exercises

  validates :name, presence: true

  def performed_at_formatted
    performed_at.strftime("%a %D %l:%M %p")
  end
end
