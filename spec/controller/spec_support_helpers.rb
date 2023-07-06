# (current_user)
def authentificate_test_user
  # Your code here

  user = User.find_by(email: 'testemail@gmail.com')

  if user
    visit '/users/sign_in'
    fill_in 'Email*', with: 'testemail@gmail.com'
    fill_in 'Password*', with: 'testPassword'
    click_button 'Log in'
  else
    # sign up
    visit '/users/sign_up'
    fill_in 'Name*', with: 'testName'
    fill_in 'Email*', with: 'testemail@gmail.com'
    fill_in 'Password*', with: 'testPassword'
    fill_in 'Password Confirmation*', with: 'testPassword'
    click_button 'Join Us Now !'
    user = User.find_by(email: 'testemail@gmail.com')
  end
  user
end
