require 'rails_helper'

RSpec.describe 'Workouts New', type: :feature do
  let(:user) { create(:user) }
  let!(:template) { create(:workout_template, name: 'Push Day', description: 'Upper body workout') }

  before { sign_in_as(user) }

  it 'creates a new workout' do
    visit new_workout_path
    click_button 'Create'
    expect(Workout.count).to eq(1)
  end

  it 'creates workout from template on new workout page' do
    visit new_workout_path
    click_button 'Use Template', match: :first
    
    expect(page).to have_content('Workout created from template successfully!')
    expect(Workout.count).to eq(1)
  end

  it 'allows user to create workout, add exercises, and log sets' do
    exercise = create(:exercise, name: 'Bench Press', category: 'Strength', equipment: 'Barbell')
    
    # Create a new workout
    visit new_workout_path
    fill_in 'Name', with: 'My First Workout'
    fill_in 'Notes', with: 'Great workout!'
    click_button 'Create'
    
    expect(page).to have_content('My First Workout')
    expect(Workout.count).to eq(1)
    
    workout = Workout.last
    
    # Add exercise to workout
    click_link 'Add Exercise'
    select 'Bench Press', from: 'Exercise'
    fill_in 'Order', with: '1'
    fill_in 'Notes', with: 'Focus on form'
    click_button 'Add Exercise'
    
    expect(page).to have_content('Exercise added to workout')
    expect(workout.workout_exercises.count).to eq(1)
    
    # Add sets to the exercise
    click_link 'Bench Press'  # Navigate to workout exercise show page
    click_link 'Add Set'
    fill_in 'Set number', with: '1'
    fill_in 'Reps', with: '10'
    fill_in 'Weight', with: '135'
    click_button 'Add Set'
    
    expect(page).to have_content('Set added to exercise')
    expect(workout.workout_exercises.first.workout_sets.count).to eq(1)
    
    # Add another set
    click_link 'Add Set'
    fill_in 'Set number', with: '2'
    fill_in 'Reps', with: '8'
    fill_in 'Weight', with: '145'
    click_button 'Add Set'
    
    expect(workout.workout_exercises.first.workout_sets.count).to eq(2)
    
    # Verify the workout shows all data
    visit workout_path(workout)
    expect(page).to have_content('My First Workout')
    expect(page).to have_content('Great workout!')
    expect(page).to have_content('Bench Press')
    expect(page).to have_content('Focus on form')
  end
end
