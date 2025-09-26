require 'rails_helper'

RSpec.describe 'Exercises Index', type: :feature do
  let(:user) { create(:user) }
  let!(:exercise1) { create(:exercise, name: 'Bench Press') }
  let!(:exercise2) { create(:exercise, name: 'Squat') }

  before { sign_in_as(user) }

  it 'displays all exercises' do
    visit exercises_path
    expect(page).to have_content('Exercise Library')
    expect(page).to have_content('Bench Press')
    expect(page).to have_content('Squat')
  end

  it 'can navigate to new exercise page' do
    visit exercises_path
    click_link 'New Exercise'
    expect(page).to have_content('New Exercise')
  end

  it 'can navigate back to workouts' do
    visit exercises_path
    click_link 'Back to Workouts'
    expect(page).to have_content('Workouts')
  end

  it 'can view individual exercises' do
    visit exercises_path
    click_link 'Bench Press'
    expect(page).to have_content('Bench Press')
  end

  it 'can edit exercises' do
    visit exercises_path
    click_link 'Edit', match: :first
    expect(page).to have_content('Edit Exercise')
  end

  it 'can delete exercises' do
    visit exercises_path
    expect { click_link 'Delete', match: :first }.to change(Exercise, :count).by(-1)
  end

end
