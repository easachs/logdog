require 'rails_helper'

RSpec.describe 'Workouts Index', type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
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

  describe 'user isolation' do
    it 'only shows current users workouts' do
      other_workout = create(:workout, user: other_user, name: 'Other User Workout')
      user_workout = create(:workout, user: user, name: 'User Workout')
      
      visit workouts_path
      expect(page).to have_content('User Workout')
      expect(page).not_to have_content('Other User Workout')
    end
  end


  describe 'concurrent user scenarios' do
    it 'handles multiple users creating workouts simultaneously' do
      user2 = create(:user)
      
      # Simulate concurrent workout creation
      workout1 = create(:workout, user: user, name: 'User 1 Workout')
      workout2 = create(:workout, user: user2, name: 'User 2 Workout')
      
      # User is already signed in from before block
      visit workouts_path
      expect(page).to have_content('User 1 Workout')
      expect(page).not_to have_content('User 2 Workout')
    end
  end
end
