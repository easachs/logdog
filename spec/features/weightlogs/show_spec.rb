require 'rails_helper'

RSpec.describe 'Weightlogs Show', type: :feature do
  let(:user) { create(:user) }
  let(:weightlog) { create(:weightlog, user: user, weight: 180.5, logged_at: Date.current) }

  before { sign_in_as(user) }

  it 'displays weight log details' do
    visit weightlog_path(weightlog)
    expect(page).to have_content('Weight Log')
    expect(page).to have_content('180.5 lbs')
    expect(page).to have_content(Date.current.strftime('%B %d, %Y'))
  end

  it 'can navigate to edit weight log' do
    visit weightlog_path(weightlog)
    click_link 'Edit'
    expect(page).to have_content('Edit Weight Log')
  end

  it 'can delete weight log' do
    visit weightlog_path(weightlog)
    expect {
      click_link 'Delete'
    }.to change(Weightlog, :count).by(-1)
    expect(page).to have_content('Weight log deleted successfully!')
  end

  it 'can navigate back to weight tracking' do
    visit weightlog_path(weightlog)
    click_link 'Back to Weight Tracking'
    expect(page).to have_content('Weight Tracking')
  end
end
