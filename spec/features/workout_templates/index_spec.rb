require 'rails_helper'

RSpec.describe 'Workout Templates Index', type: :feature do
  let(:user) { create(:user) }
  let!(:template1) { create(:workout_template, name: 'Push Day') }
  let!(:template2) { create(:workout_template, name: 'Pull Day') }

  before { sign_in_as(user) }

  it 'displays all templates' do
    visit workout_templates_path
    expect(page).to have_content('Workout Templates')
    expect(page).to have_content('Push Day')
    expect(page).to have_content('Pull Day')
  end

  it 'can navigate to new template page' do
    visit workout_templates_path
    click_link 'New Template'
    expect(page).to have_content('New Workout Template')
  end

  it 'can navigate back to workouts' do
    visit workout_templates_path
    click_link 'Back to Workouts'
    expect(page).to have_content('Workouts')
  end

  it 'can view individual templates' do
    visit workout_templates_path
    click_link 'Push Day'
    expect(page).to have_content('Push Day')
  end

  it 'can manage exercises for templates' do
    visit workout_templates_path
    click_link 'Manage Exercises', match: :first
    expect(page).to have_content('Exercises in')
  end

  it 'can edit templates' do
    visit workout_templates_path
    click_link 'Edit', match: :first
    expect(page).to have_content('Edit Workout Template')
  end

  it 'can delete templates' do
    visit workout_templates_path
    expect { click_link 'Delete', match: :first }.to change(WorkoutTemplate, :count).by(-1)
  end

  it 'can create workout from template' do
    visit workout_templates_path
    click_button 'Create Workout from Template', match: :first
    expect(page).to have_content('Workout created from template successfully!')
  end

  it 'creates workout from template with all exercises' do
    exercise1 = create(:exercise, name: 'Bench Press')
    exercise2 = create(:exercise, name: 'Shoulder Press')
    # Create a new template that will be first in the list
    template = create(:workout_template, name: 'Push Day', description: 'Upper body workout')
    create(:workout_template_exercise, workout_template: template, exercise: exercise1, order: 1, notes: 'Focus on form')
    create(:workout_template_exercise, workout_template: template, exercise: exercise2, order: 2, notes: 'Go heavy')
    
    visit workout_templates_path
    # Find the specific template button
    within("#workout_template_#{template.id}") do
      click_button 'Create Workout from Template'
    end
    
    expect(page).to have_content('Workout created from template successfully!')
    expect(Workout.count).to eq(1)
    
    workout = Workout.last
    expect(workout.name).to include('Push Day')
    expect(workout.workout_exercises.count).to eq(2)
    
    # Check that exercises are in correct order
    workout_exercises = workout.workout_exercises.order(:order)
    expect(workout_exercises.first.exercise.name).to eq('Bench Press')
    expect(workout_exercises.first.notes).to eq('Focus on form')
    expect(workout_exercises.second.exercise.name).to eq('Shoulder Press')
    expect(workout_exercises.second.notes).to eq('Go heavy')
  end

end
