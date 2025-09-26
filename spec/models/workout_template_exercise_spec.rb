require 'rails_helper'

RSpec.describe WorkoutTemplateExercise, type: :model do
  describe 'associations' do
    it { should belong_to(:workout_template) }
    it { should belong_to(:exercise) }
  end

  describe 'validations' do
    it { should validate_presence_of(:exercise_id) }
    it { should validate_presence_of(:order) }
    it { should validate_numericality_of(:order).is_greater_than_or_equal_to(0) }
  end
end
