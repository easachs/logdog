require 'rails_helper'

RSpec.describe 'Weightlogs Edit', type: :feature do
  let(:user) { create(:user) }
  let(:weightlog) { create(:weightlog, user: user, weight: 180.0, logged_at: Date.current) }

  before { sign_in_as(user) }

  it 'updates the weight log' do
    visit edit_weightlog_path(weightlog)
    fill_in 'Weight', with: '181.5'
    click_button 'Update Weight'
    
    expect(page).to have_content('Weight updated successfully!')
    weightlog.reload
    expect(weightlog.weight).to eq(181.5)
  end

  it 'shows validation errors for invalid data' do
    visit edit_weightlog_path(weightlog)
    fill_in 'Weight', with: ''
    click_button 'Update Weight'
    expect(page).to have_content("Weight can't be blank")
  end

  it 'can navigate back to weight tracking' do
    visit edit_weightlog_path(weightlog)
    click_link 'Back to Weight Tracking'
    expect(page).to have_content('Weight Tracking')
  end
end
