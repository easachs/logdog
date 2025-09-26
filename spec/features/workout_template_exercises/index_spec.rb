require 'rails_helper'

RSpec.describe 'Workout Template Exercises Index', type: :feature do
  let(:user) { create(:user) }
  let(:template) { create(:workout_template, name: 'Push Day') }
  let!(:exercise1) { create(:exercise, name: 'Bench Press') }
  let!(:exercise2) { create(:exercise, name: 'Shoulder Press') }
  let!(:template_exercise1) { create(:workout_template_exercise, workout_template: template, exercise: exercise1, order: 1) }
  let!(:template_exercise2) { create(:workout_template_exercise, workout_template: template, exercise: exercise2, order: 2) }

  before { sign_in_as(user) }

  it 'displays template exercises' do
    visit workout_template_workout_template_exercises_path(template)
    expect(page).to have_content('Exercises in Push Day')
    expect(page).to have_content('Bench Press')
    expect(page).to have_content('Shoulder Press')
  end

  it 'can navigate to add exercise page' do
    visit workout_template_workout_template_exercises_path(template)
    click_link 'Add Exercise'
    expect(page).to have_content('Add Exercise to Push Day')
  end

  it 'can navigate back to template' do
    visit workout_template_workout_template_exercises_path(template)
    click_link 'Back to Template'
    expect(page).to have_content('Push Day')
  end

  it 'can view individual template exercises' do
    visit workout_template_workout_template_exercises_path(template)
    click_link 'Bench Press'
    expect(page).to have_content('Bench Press')
  end

  it 'can edit template exercises' do
    visit workout_template_workout_template_exercises_path(template)
    click_link 'Edit', match: :first
    expect(page).to have_content('Edit Exercise in Push Day')
  end

  it 'can remove template exercises' do
    visit workout_template_workout_template_exercises_path(template)
    expect { click_link 'Remove', match: :first }.to change(WorkoutTemplateExercise, :count).by(-1)
  end

  it 'shows message when no exercises' do
    template.workout_template_exercises.destroy_all
    visit workout_template_workout_template_exercises_path(template)
    expect(page).to have_content('No exercises added to this template yet')
  end
end
