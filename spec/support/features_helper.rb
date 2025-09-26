module FeaturesHelper
  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def sign_out
    if page.has_link?('Sign out')
      click_link 'Sign out'
    else
      # If no sign out link, try to visit logout path directly
      visit destroy_user_session_path
    end
  end
end
