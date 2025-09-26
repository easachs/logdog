require 'rails_helper'

RSpec.describe 'Workout Sets Edit', type: :feature do
  let(:user) { create(:user) }
  let(:workout) { create(:workout, user: user, name: 'My Workout') }
  let(:exercise) { create(:exercise, name: 'Bench Press') }
  let!(:workout_exercise) { create(:workout_exercise, workout: workout, exercise: exercise) }
  let!(:workout_set) { create(:workout_set, workout_exercise: workout_exercise, set_number: 1, reps: 10, weight: 135) }

  before { sign_in_as(user) }

  it 'updates the workout set' do
    visit edit_workout_workout_exercise_workout_set_path(workout, workout_exercise, workout_set)
    fill_in 'Reps', with: '12'
    fill_in 'Weight', with: '145'
    click_button 'Update Set'
    expect(page).to have_content('Set updated')
  end

  it 'shows validation errors for invalid data' do
    visit edit_workout_workout_exercise_workout_set_path(workout, workout_exercise, workout_set)
    fill_in 'Reps', with: ''
    click_button 'Update Set'
    expect(page).to have_content("Reps can't be blank")
  end

  it 'can navigate back to workout exercise' do
    visit edit_workout_workout_exercise_workout_set_path(workout, workout_exercise, workout_set)
    click_link 'Back to Exercise'
    expect(page).to have_content('Bench Press')
  end
end
