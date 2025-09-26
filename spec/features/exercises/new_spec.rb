require 'rails_helper'

RSpec.describe 'Exercises New', type: :feature do
  let(:user) { create(:user) }

  before { sign_in_as(user) }

  it 'creates a new exercise' do
    visit new_exercise_path
    fill_in 'Name', with: 'Deadlift'
    select 'Push', from: 'Category'
    select 'Barbell', from: 'Equipment'
    fill_in 'Description', with: 'A compound movement'
    click_button 'Create Exercise'
    
    expect(page).to have_content('Exercise was successfully created')
    expect(Exercise.count).to eq(1)
  end

  it 'shows validation errors for missing name' do
    visit new_exercise_path
    click_button 'Create Exercise'
    expect(page).to have_content("Name can't be blank")
  end

  it 'can navigate back to exercise library' do
    visit new_exercise_path
    click_link 'Back to Exercise Library'
    expect(page).to have_content('Exercise Library')
  end
end
