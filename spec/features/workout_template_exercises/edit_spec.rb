require 'rails_helper'

RSpec.describe 'Workout Template Exercises Edit', type: :feature do
  let(:user) { create(:user) }
  let(:template) { create(:workout_template, name: 'Push Day') }
  let(:exercise) { create(:exercise, name: 'Bench Press') }
  let!(:template_exercise) { create(:workout_template_exercise, workout_template: template, exercise: exercise, order: 1, notes: 'Original notes') }

  before { sign_in_as(user) }

  it 'updates the template exercise' do
    visit edit_workout_template_workout_template_exercise_path(template, template_exercise)
    fill_in 'Order', with: '2'
    fill_in 'Template Notes', with: 'Updated notes'
    click_button 'Update Exercise'
    expect(page).to have_content('Template exercise updated successfully!')
  end

  it 'shows validation errors for invalid data' do
    visit edit_workout_template_workout_template_exercise_path(template, template_exercise)
    fill_in 'Order', with: ''
    click_button 'Update Exercise'
    expect(page).to have_content("Order can't be blank")
  end

  it 'can navigate back to template exercise' do
    visit edit_workout_template_workout_template_exercise_path(template, template_exercise)
    click_link 'Back to Exercise'
    expect(page).to have_content('Bench Press')
  end
end
