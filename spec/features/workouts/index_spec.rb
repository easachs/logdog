require 'rails_helper'

RSpec.describe 'Workouts Index', type: :feature do
  let(:user) { create(:user) }
  let!(:workout) { create(:workout, user: user) }

  before { sign_in_as(user) }

  it 'displays the workouts' do
    visit workouts_path
    expect(page).to have_content(workout.name)
  end

  it 'can edit workouts' do
    visit workouts_path
    expect(page).to have_link('Edit')
  end

  it 'can delete workout' do
    visit workouts_path
    expect(page).to have_button('Delete')
  end
end
