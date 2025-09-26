require 'rails_helper'

RSpec.describe 'Workout Template Exercises New', type: :feature do
  let(:user) { create(:user) }
  let(:template) { create(:workout_template, name: 'Push Day') }
  let!(:exercise) { create(:exercise, name: 'Bench Press') }

  before { sign_in_as(user) }

  it 'adds exercise to template' do
    visit new_workout_template_workout_template_exercise_path(template)
    select 'Bench Press', from: 'Exercise'
    fill_in 'Order', with: '1'
    fill_in 'Template Notes', with: 'Focus on form'
    click_button 'Add Exercise'
    
    expect(page).to have_content('Exercise added to template successfully!')
    expect(template.workout_template_exercises.count).to eq(1)
  end

  it 'shows validation errors for missing exercise' do
    visit new_workout_template_workout_template_exercise_path(template)
    click_button 'Add Exercise'
    expect(page).to have_content("Exercise can't be blank")
  end

  it 'can navigate back to template' do
    visit new_workout_template_workout_template_exercise_path(template)
    click_link 'Back to Template'
    expect(page).to have_content('Push Day')
  end

  it 'can navigate to create new exercise' do
    visit new_workout_template_workout_template_exercise_path(template)
    click_link 'Create New Exercise'
    expect(page).to have_content('New Exercise')
  end
end
