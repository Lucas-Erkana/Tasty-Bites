require 'rails_helper'

RSpec.describe Food, type: :system do
  before(:each) do
    authentificate_test_user
    expect(page).to have_content('Log Out')
  end

  it 'can see the food new page' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/foods/new'
    expect(page).to have_content('New Food')
  end

  it 'can submit food form' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/foods/new'
    fill_in 'Name', with: 'Tomato'
    fill_in 'Measurement unit', with: 'gram'
    fill_in 'Price', with: 10
    fill_in 'Quantity', with: 3
    click_button 'Create Food'
    expect(page).to have_content('Food was successfully created.')

    # new food is visible in food#index
    visit '/foods'
    expect(page).to have_content('Tomato')
  end
end
