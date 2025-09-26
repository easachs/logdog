require 'rails_helper'

RSpec.describe 'Workout Exercises Index', type: :feature do
  let(:user) { create(:user) }
  let(:workout) { create(:workout, user: user, name: 'My Workout') }
  let!(:exercise1) { create(:exercise, name: 'Bench Press') }
  let!(:exercise2) { create(:exercise, name: 'Squat') }
  let!(:workout_exercise1) { create(:workout_exercise, workout: workout, exercise: exercise1, order: 1) }
  let!(:workout_exercise2) { create(:workout_exercise, workout: workout, exercise: exercise2, order: 2) }

  before { sign_in_as(user) }

  it 'displays workout exercises' do
    visit workout_workout_exercises_path(workout)
    expect(page).to have_content('Exercises in My Workout')
    expect(page).to have_content('Bench Press')
    expect(page).to have_content('Squat')
  end

  it 'can navigate to add exercise page' do
    visit workout_workout_exercises_path(workout)
    click_link 'Add Exercise'
    expect(page).to have_content('Add Exercise to My Workout')
  end

  it 'can navigate back to workout' do
    visit workout_workout_exercises_path(workout)
    click_link 'Back to Workout'
    expect(page).to have_content('My Workout')
  end

  it 'can view individual workout exercises' do
    visit workout_workout_exercises_path(workout)
    click_link 'Bench Press'
    expect(page).to have_content('Bench Press')
  end

  it 'can edit workout exercises' do
    visit workout_workout_exercises_path(workout)
    click_link 'Edit', match: :first
    expect(page).to have_content('Edit Exercise in My Workout')
  end

  it 'can remove workout exercises' do
    visit workout_workout_exercises_path(workout)
    expect { click_link 'Remove', match: :first }.to change(WorkoutExercise, :count).by(-1)
  end

  it 'shows message when no exercises' do
    workout.workout_exercises.destroy_all
    visit workout_workout_exercises_path(workout)
    expect(page).to have_content('No exercises added to this workout yet')
  end
end
