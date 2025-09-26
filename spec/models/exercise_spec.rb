require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe 'associations' do
    it { should have_many(:workout_exercises).dependent(:destroy) }
    it { should have_many(:workout_template_exercises).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'scopes' do
    let!(:exercise1) { create(:exercise, name: 'Bench Press') }
    let!(:exercise2) { create(:exercise, name: 'Squat') }

    it 'orders by name' do
      expect(Exercise.order(:name)).to eq([exercise1, exercise2])
    end
  end

  describe 'data integrity' do
    it 'maintains referential integrity when exercise is deleted' do
      workout = create(:workout)
      exercise = create(:exercise)
      workout_exercise = create(:workout_exercise, workout: workout, exercise: exercise)
      
      # Exercise deletion should cascade delete workout_exercise due to foreign key constraint
      expect {
        exercise.destroy
      }.to change(WorkoutExercise, :count).by(-1)
      expect { workout_exercise.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
