require 'rails_helper'

RSpec.describe 'Workout Templates Edit', type: :feature do
  let(:user) { create(:user) }
  let(:template) { create(:workout_template, name: 'Push Day') }

  before { sign_in_as(user) }

  it 'updates the template' do
    visit edit_workout_template_path(template)
    fill_in 'Name', with: 'Upper Body Day'
    click_button 'Update Template'
    expect(page).to have_content('Upper Body Day')
  end

  it 'shows validation errors for invalid data' do
    visit edit_workout_template_path(template)
    fill_in 'Name', with: ''
    click_button 'Update Template'
    expect(page).to have_content("Name can't be blank")
  end

  it 'can navigate back to template' do
    visit edit_workout_template_path(template)
    click_link 'Back to Template'
    expect(page).to have_content('Push Day')
  end
end
