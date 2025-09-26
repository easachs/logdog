require 'rails_helper'

RSpec.describe 'Workout Template Exercises Show', type: :feature do
  let(:user) { create(:user) }
  let(:template) { create(:workout_template, name: 'Push Day') }
  let(:exercise) { create(:exercise, name: 'Bench Press', category: 'Strength', equipment: 'Barbell', description: 'A great exercise') }
  let!(:template_exercise) { create(:workout_template_exercise, workout_template: template, exercise: exercise, order: 1, notes: 'Focus on form') }

  before { sign_in_as(user) }

  it 'displays template exercise details' do
    visit workout_template_workout_template_exercise_path(template, template_exercise)
    expect(page).to have_content('Bench Press')
    expect(page).to have_content('Strength')
    expect(page).to have_content('Barbell')
    expect(page).to have_content('Focus on form')
  end

  it 'can edit the template exercise' do
    visit workout_template_workout_template_exercise_path(template, template_exercise)
    click_link 'Edit Exercise'
    expect(page).to have_content('Edit Exercise in Push Day')
  end

  it 'can navigate back to template' do
    visit workout_template_workout_template_exercise_path(template, template_exercise)
    click_link 'Back to Template'
    expect(page).to have_content('Push Day')
  end
end
