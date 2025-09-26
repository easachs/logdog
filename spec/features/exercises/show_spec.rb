require 'rails_helper'

RSpec.describe 'Exercises Show', type: :feature do
  let(:user) { create(:user) }
  let(:exercise) { create(:exercise, name: 'Bench Press', category: 'Strength', equipment: 'Barbell', description: 'A great exercise') }

  before { sign_in_as(user) }

  it 'displays exercise details' do
    visit exercise_path(exercise)
    expect(page).to have_content('Bench Press')
    expect(page).to have_content('Strength')
    expect(page).to have_content('Barbell')
    expect(page).to have_content('A great exercise')
  end

  it 'can edit the exercise' do
    visit exercise_path(exercise)
    click_link 'Edit'
    expect(page).to have_content('Edit Exercise')
  end

  it 'can delete the exercise' do
    visit exercise_path(exercise)
    expect { click_link 'Delete' }.to change(Exercise, :count).by(-1)
  end

  it 'can navigate back to exercise library' do
    visit exercise_path(exercise)
    click_link 'Back to Exercise Library'
    expect(page).to have_content('Exercise Library')
  end
end
