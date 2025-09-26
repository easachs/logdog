require 'rails_helper'

RSpec.describe 'Workout Exercises Show', type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:workout) { create(:workout, user: user, name: 'My Workout') }
  let(:exercise) { create(:exercise, name: 'Bench Press', category: 'Strength', equipment: 'Barbell', description: 'A great exercise') }
  let!(:workout_exercise) { create(:workout_exercise, workout: workout, exercise: exercise, order: 1, notes: 'Focus on form') }

  before { sign_in_as(user) }

  it 'displays workout exercise details' do
    visit workout_workout_exercise_path(workout, workout_exercise)
    expect(page).to have_content('Bench Press')
    expect(page).to have_content('Strength')
    expect(page).to have_content('Barbell')
    expect(page).to have_content('Focus on form')
  end

  it 'can add sets to workout exercise' do
    visit workout_workout_exercise_path(workout, workout_exercise)
    click_link 'Add Set'
    expect(page).to have_content('Add Set to Bench Press')
  end

  it 'can edit the workout exercise' do
    visit workout_workout_exercise_path(workout, workout_exercise)
    click_link 'Edit Exercise'
    expect(page).to have_content('Edit Exercise in My Workout')
  end

  it 'can navigate back to workout' do
    visit workout_workout_exercise_path(workout, workout_exercise)
    click_link 'Back to Workout'
    expect(page).to have_content('My Workout')
  end

end
