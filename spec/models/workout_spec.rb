require 'rails_helper'

RSpec.describe Workout, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:workout_exercises).dependent(:destroy) }
    it { should have_many(:exercises).through(:workout_exercises) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'performed_at_formatted' do
    it 'formats the performed_at date correctly' do
      workout = create(:workout, performed_at: Time.zone.parse('2025-01-01 12:00:00'))
      expect(workout.performed_at_formatted).to eq('Wed 01/01/25 12:00 PM')
    end
  end
end
