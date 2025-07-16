require 'rails_helper'

RSpec.describe 'Workouts Update', type: :feature do
  let(:user) { create(:user) }
  let(:workout) { create(:workout, user: user) }

  before { sign_in_as(user) }

  it 'updates the workout' do
    visit edit_workout_path(workout)
    fill_in 'Name', with: 'Workout #2'
    click_button 'Update'
    expect(page).to have_content('Workout #2')
  end
end
