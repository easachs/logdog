require 'rails_helper'

RSpec.describe 'Workouts Show', type: :feature do
  let(:user) { create(:user) }
  let(:workout) { create(:workout, user: user) }

  before { sign_in_as(user) }

  it 'displays the workout' do
    visit workout_path(workout)
    expect(page).to have_content(workout.name)
  end

  it 'can edit workout' do
    visit workout_path(workout)
    click_link 'Edit'
    expect(page).to have_content('Edit Workout')
  end

  it 'can delete workout' do
    visit workout_path(workout)
    click_button 'Delete'
    expect(Workout.count).to eq(0)
  end
end
