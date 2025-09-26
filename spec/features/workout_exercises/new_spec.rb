require 'rails_helper'

RSpec.describe 'Workout Exercises New', type: :feature do
  let(:user) { create(:user) }
  let(:workout) { create(:workout, user: user, name: 'My Workout') }
  let!(:exercise) { create(:exercise, name: 'Bench Press') }

  before { sign_in_as(user) }

  it 'adds exercise to workout' do
    visit new_workout_workout_exercise_path(workout)
    select 'Bench Press', from: 'Exercise'
    fill_in 'Order', with: '1'
    fill_in 'Notes', with: 'Focus on form'
    click_button 'Add Exercise'
    
    expect(page).to have_content('Exercise added to workout')
    expect(workout.workout_exercises.count).to eq(1)
  end

  it 'shows validation errors for missing exercise' do
    visit new_workout_workout_exercise_path(workout)
    click_button 'Add Exercise'
    expect(page).to have_content("Exercise can't be blank")
  end

  it 'can navigate back to workout' do
    visit new_workout_workout_exercise_path(workout)
    click_link 'Back to Workout'
    expect(page).to have_content('My Workout')
  end

  it 'can navigate to create new exercise' do
    visit new_workout_workout_exercise_path(workout)
    click_link 'Create New Exercise'
    expect(page).to have_content('New Exercise')
  end
end
