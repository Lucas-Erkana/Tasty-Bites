require 'rails_helper'

RSpec.describe RecipesController, type: :system do
  before(:all) do
    user = authentificate_test_user
    @recipe = Recipe.first
    @recipe ||= Recipe.create(name: 'Pizza Recipe', description: 'Salt',
                              preparation_time: 10, cooking_time: 3, public: true, user:)
  end

  it 'can see the recipe index page with recipe elements' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/recipes'
    expect(page).to have_content('List Recipes')
  end

  it 'can see recipe elements' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/recipes'
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content(@recipe.description)
  end

  it 'Btn add recipe should navigate to new' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/recipes'
    click_button 'Add Recipe'

    expect(has_current_path?('/recipes/new', wait: 5)).to be_truthy
  end
end
