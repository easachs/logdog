require 'rails_helper'

RSpec.describe 'Workout Exercises Edit', type: :feature do
  let(:user) { create(:user) }
  let(:workout) { create(:workout, user: user, name: 'My Workout') }
  let(:exercise) { create(:exercise, name: 'Bench Press') }
  let!(:workout_exercise) { create(:workout_exercise, workout: workout, exercise: exercise, order: 1, notes: 'Original notes') }

  before { sign_in_as(user) }

  it 'updates the workout exercise' do
    visit edit_workout_workout_exercise_path(workout, workout_exercise)
    fill_in 'Order', with: '2'
    fill_in 'Notes', with: 'Updated notes'
    click_button 'Update Exercise'
    expect(page).to have_content('Workout exercise updated')
  end

  it 'shows validation errors for invalid data' do
    visit edit_workout_workout_exercise_path(workout, workout_exercise)
    fill_in 'Order', with: ''
    click_button 'Update Exercise'
    expect(page).to have_content("Order can't be blank")
  end

  it 'can navigate back to workout exercise' do
    visit edit_workout_workout_exercise_path(workout, workout_exercise)
    click_link 'Back to Exercise'
    expect(page).to have_content('Bench Press')
  end
end
