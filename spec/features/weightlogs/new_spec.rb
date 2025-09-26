require 'rails_helper'

RSpec.describe 'Weightlogs New', type: :feature do
  let(:user) { create(:user) }

  before { sign_in_as(user) }

  it 'creates a new weight log' do
    visit new_weightlog_path
    fill_in 'Weight', with: '180.5'
    fill_in 'Date', with: Date.current.strftime('%Y-%m-%d')
    click_button 'Log Weight'

    expect(page).to have_content('Weight logged successfully!')
    expect(Weightlog.count).to eq(1)
    expect(Weightlog.last.weight).to eq(180.5)
  end

  it 'shows validation errors for missing weight' do
    visit new_weightlog_path
    click_button 'Log Weight'
    expect(page).to have_content("Weight can't be blank")
  end

  it 'shows validation errors for invalid weight' do
    visit new_weightlog_path
    fill_in 'Weight', with: '-10'
    click_button 'Log Weight'
    expect(page).to have_content('Weight must be greater than 0')
  end

  it 'updates existing log for the same date' do
    existing_log = create(:weightlog, user: user, weight: 180.0, logged_at: Date.current)
    
    visit new_weightlog_path
    fill_in 'Weight', with: '181.0'
    fill_in 'Date', with: Date.current.strftime('%Y-%m-%d')
    click_button 'Log Weight'
    
    expect(page).to have_content('Weight updated successfully!')
    existing_log.reload
    expect(existing_log.weight).to eq(181.0)
  end

  it 'can navigate back to weight tracking' do
    visit new_weightlog_path
    click_link 'Back to Weight Tracking'
    expect(page).to have_content('Weight Tracking')
  end
end
