require 'rails_helper'

RSpec.describe 'Workout Sets New', type: :feature do
  let(:user) { create(:user) }
  let(:workout) { create(:workout, user: user, name: 'My Workout') }
  let(:exercise) { create(:exercise, name: 'Bench Press') }
  let!(:workout_exercise) { create(:workout_exercise, workout: workout, exercise: exercise) }

  before { sign_in_as(user) }

  it 'adds set to workout exercise' do
    visit new_workout_workout_exercise_workout_set_path(workout, workout_exercise)
    fill_in 'Set number', with: '1'
    fill_in 'Reps', with: '10'
    fill_in 'Weight', with: '135'
    click_button 'Add Set'
    
    expect(page).to have_content('Set added to exercise')
    expect(workout_exercise.workout_sets.count).to eq(1)
  end

  it 'shows validation errors for missing data' do
    visit new_workout_workout_exercise_workout_set_path(workout, workout_exercise)
    click_button 'Add Set'
    expect(page).to have_content("Reps can't be blank")
  end

  it 'can navigate back to workout exercise' do
    visit new_workout_workout_exercise_workout_set_path(workout, workout_exercise)
    click_link 'Back to Exercise'
    expect(page).to have_content('Bench Press')
  end
end
