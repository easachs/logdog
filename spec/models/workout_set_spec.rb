require 'rails_helper'

RSpec.describe WorkoutSet, type: :model do
  describe 'associations' do
    it { should belong_to(:workout_exercise) }
  end

  describe 'validations' do
    it { should validate_presence_of(:set_number) }
    it { should validate_presence_of(:reps) }
    it { should validate_presence_of(:weight) }
    it { should validate_numericality_of(:set_number).is_greater_than(0) }
    it { should validate_numericality_of(:reps).is_greater_than(0) }
    it { should validate_numericality_of(:weight).is_greater_than(0) }
  end
end
