require 'rails_helper'

RSpec.describe 'Exercises Edit', type: :feature do
  let(:user) { create(:user) }
  let(:exercise) { create(:exercise, name: 'Bench Press') }

  before { sign_in_as(user) }

  it 'updates the exercise' do
    visit edit_exercise_path(exercise)
    fill_in 'Name', with: 'Incline Bench Press'
    click_button 'Update Exercise'
    expect(page).to have_content('Exercise was successfully updated')
  end

  it 'shows validation errors for invalid data' do
    visit edit_exercise_path(exercise)
    fill_in 'Name', with: ''
    click_button 'Update Exercise'
    expect(page).to have_content("Name can't be blank")
  end

  it 'can navigate back to exercise' do
    visit edit_exercise_path(exercise)
    click_link 'Back to Exercise'
    expect(page).to have_content('Bench Press')
  end
end
