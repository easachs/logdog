require 'rails_helper'

RSpec.describe 'Workouts Show', type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:workout) { create(:workout, user: user) }

  before { sign_in_as(user) }

  it 'displays the workout' do
    visit workout_path(workout)
    expect(page).to have_content(workout.name)
  end

  it 'can edit workout' do
    visit workout_path(workout)
    click_link 'Edit'
    expect(page).to have_content('Edit Workout')
  end

  it 'can delete workout' do
    visit workout_path(workout)
    click_button 'Delete'
    expect(Workout.count).to eq(0)
  end


  describe 'edge cases' do
    it 'handles workout with no exercises' do
      empty_workout = create(:workout, user: user, name: 'Empty Workout')
      visit workout_path(empty_workout)
      expect(page).to have_content('No exercises added to this workout yet')
    end

    it 'handles exercise with no sets' do
      workout = create(:workout, user: user)
      exercise = create(:exercise)
      workout_exercise = create(:workout_exercise, workout: workout, exercise: exercise)
      
      visit workout_workout_exercise_path(workout, workout_exercise)
      expect(page).to have_content('No sets added yet')
    end
  end
end
