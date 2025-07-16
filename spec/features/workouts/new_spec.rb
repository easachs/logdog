require 'rails_helper'

RSpec.describe 'Workouts New', type: :feature do
  let(:user) { create(:user) }

  before { sign_in_as(user) }

  it 'creates a new workout' do
    visit new_workout_path
    click_button 'Create'
    expect(Workout.count).to eq(1)
  end
end
