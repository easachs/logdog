require 'rails_helper'

RSpec.describe 'Workout Templates Show', type: :feature do
  let(:user) { create(:user) }
  let(:template) { create(:workout_template, name: 'Push Day', description: 'Upper body workout') }
  let!(:exercise) { create(:exercise, name: 'Bench Press') }
  let!(:template_exercise) { create(:workout_template_exercise, workout_template: template, exercise: exercise, order: 1, notes: 'Focus on form') }

  before { sign_in_as(user) }

  it 'displays template details' do
    visit workout_template_path(template)
    expect(page).to have_content('Push Day')
    expect(page).to have_content('Upper body workout')
  end

  it 'displays template exercises' do
    visit workout_template_path(template)
    expect(page).to have_content('Bench Press')
    expect(page).to have_content('Focus on form')
  end

  it 'can create workout from template' do
    visit workout_template_path(template)
    click_button 'Create Workout from Template'
    expect(page).to have_content('Workout created from template successfully!')
  end

  it 'creates workout from template show page' do
    visit workout_template_path(template)
    click_button 'Create Workout from Template'
    
    expect(page).to have_content('Workout created from template successfully!')
    expect(Workout.count).to eq(1)
  end

  it 'can edit template' do
    visit workout_template_path(template)
    click_link 'Edit Template'
    expect(page).to have_content('Edit Workout Template')
  end

  it 'can manage exercises' do
    visit workout_template_path(template)
    click_link 'Manage Exercises'
    expect(page).to have_content('Exercises in Push Day')
  end

  it 'can navigate back to templates' do
    visit workout_template_path(template)
    click_link 'Back to Templates'
    expect(page).to have_content('Workout Templates')
  end

  describe 'edge cases' do
    it 'handles template with no exercises gracefully' do
      empty_template = create(:workout_template, name: 'Empty Template')
      visit workout_template_path(empty_template)
      expect(page).to have_content('No exercises in this template yet')
    end

    it 'allows creating workout from empty template' do
      empty_template = create(:workout_template, name: 'Empty Template')
      visit workout_template_path(empty_template)
      click_button 'Create Workout from Template'
      
      expect(page).to have_content('Workout created from template successfully!')
    end

    it 'handles template with duplicate exercise orders' do
      template_with_duplicates = create(:workout_template)
      exercise1 = create(:exercise, name: 'Exercise 1')
      exercise2 = create(:exercise, name: 'Exercise 2')
      
      create(:workout_template_exercise, workout_template: template_with_duplicates, exercise: exercise1, order: 1)
      create(:workout_template_exercise, workout_template: template_with_duplicates, exercise: exercise2, order: 1)
      
      visit workout_template_path(template_with_duplicates)
      expect(page).to have_content('Exercise 1')
      expect(page).to have_content('Exercise 2')
    end
  end
end
