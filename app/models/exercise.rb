# == Schema Information
#
# Table name: exercises
#
#  id          :bigint           not null, primary key
#  name        :string
#  category    :string
#  equipment   :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Exercise < ApplicationRecord
  has_many :workout_exercises, dependent: :destroy
end
