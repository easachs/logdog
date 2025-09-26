require 'rails_helper'

RSpec.describe WorkoutExercise, type: :model do
  describe 'associations' do
    it { should belong_to(:workout) }
    it { should belong_to(:exercise) }
    it { should have_many(:workout_sets).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:exercise_id) }
    it { should validate_presence_of(:order) }
    it { should validate_numericality_of(:order).is_greater_than_or_equal_to(0) }
  end
end
