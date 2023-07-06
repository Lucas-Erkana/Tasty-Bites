require 'rails_helper'
require_relative '../spec_support_helpers'

RSpec.describe RecipesController, type: :system do
  it 'can see the recipe new page' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/recipes/new'
    expect(page).to have_content('New Recipe')
  end

  it 'can submit recipe form' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/recipes/new'
    fill_in 'Name', with: 'Tomato'
    fill_in 'Description', with: 'Tomato'
    fill_in 'Preparation time', with: 10
    fill_in 'Cooking time', with: 3
    click_button 'Create Recipe'
    expect(page).to have_content('Recipe was successfully created.')

    # new recipe is visible in recipe#index
    visit '/recipes'
    expect(page).to have_content('Tomato')
  end
end
