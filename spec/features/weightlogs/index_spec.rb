require 'rails_helper'

RSpec.describe 'Weightlogs Index', type: :feature do
  let(:user) { create(:user) }

  before { sign_in_as(user) }

  it 'displays weight tracking page when no logs exist' do
    visit weightlogs_path
    expect(page).to have_content('Weight Tracking')
    expect(page).to have_content('No weight logs yet')
    expect(page).to have_link('Log Your First Weight')
  end

  it 'displays weight logs and metrics when logs exist' do
    create(:weightlog, user: user, weight: 180.5, logged_at: 1.day.ago)
    create(:weightlog, user: user, weight: 179.0, logged_at: Date.current)
    
    visit weightlogs_path
    expect(page).to have_content('Weight Tracking')
    expect(page).to have_content('179.0 lbs')
    expect(page).to have_content('180.5 lbs')
    expect(page).to have_content('Current Weight')
    expect(page).to have_content('Average Weight')
  end

  it 'can navigate to log new weight' do
    visit weightlogs_path
    click_link 'Log Weight'
    expect(page).to have_content('Log Weight')
  end

  it 'can navigate back to workouts' do
    visit weightlogs_path
    click_link 'Back to Workouts'
    expect(page).to have_content('Workouts')
  end

  it 'can edit a weight log' do
    weightlog = create(:weightlog, user: user, weight: 180.0)
    visit weightlogs_path
    click_link 'Edit'
    expect(page).to have_content('Edit Weight Log')
  end

  it 'can delete a weight log' do
    weightlog = create(:weightlog, user: user, weight: 180.0)
    visit weightlogs_path
    expect {
      click_link 'Delete'
    }.to change(Weightlog, :count).by(-1)
    expect(page).to have_content('Weight log deleted successfully!')
  end
end
