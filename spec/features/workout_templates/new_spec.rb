require 'rails_helper'

RSpec.describe 'Workout Templates New', type: :feature do
  let(:user) { create(:user) }

  before { sign_in_as(user) }

  it 'creates a new template' do
    visit new_workout_template_path
    fill_in 'Name', with: 'Leg Day'
    fill_in 'Description', with: 'Lower body workout'
    click_button 'Create Template'
    
    expect(page).to have_content('Leg Day')
    expect(WorkoutTemplate.count).to eq(1)
  end

  it 'shows validation errors for missing name' do
    visit new_workout_template_path
    click_button 'Create Template'
    expect(page).to have_content("Name can't be blank")
  end

  it 'can navigate back to templates' do
    visit new_workout_template_path
    click_link 'Back to Templates'
    expect(page).to have_content('Workout Templates')
  end

  it 'allows user to create template and use it for workout' do
    exercise = create(:exercise, name: 'Bench Press', category: 'Strength', equipment: 'Barbell')
    
    # Create a template
    visit new_workout_template_path
    fill_in 'Name', with: 'Push Day'
    fill_in 'Description', with: 'Upper body workout'
    click_button 'Create Template'
    
    expect(page).to have_content('Push Day')
    expect(WorkoutTemplate.count).to eq(1)
    
    template = WorkoutTemplate.last
    
    # Add exercise to template
    click_link 'Manage Exercises'
    click_link 'Add Exercise'
    select 'Bench Press', from: 'Exercise'
    fill_in 'Order', with: '1'
    fill_in 'Template Notes', with: 'Template notes'
    click_button 'Add Exercise'
    
    expect(page).to have_content('Exercise added to template successfully!')
    expect(template.workout_template_exercises.count).to eq(1)
    
    # Create workout from template
    visit workout_templates_path
    click_button 'Create Workout from Template', match: :first
    
    expect(page).to have_content('Workout created from template successfully!')
    expect(Workout.count).to eq(1)
    
    workout = Workout.last
    expect(workout.name).to include('Push Day')
    expect(workout.workout_exercises.count).to eq(1)
    expect(workout.workout_exercises.first.notes).to eq('Template notes')
  end
end
