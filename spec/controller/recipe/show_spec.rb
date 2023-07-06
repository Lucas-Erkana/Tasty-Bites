require 'rails_helper'

RSpec.describe Recipe, type: :system do
  before(:all) do
    user = authentificate_test_user
    @recipe = Recipe.first
    @recipe ||= Recipe.create(name: 'Pizza Recipe', description: 'Salt',
                              preparation_time: 10, cooking_time: 3, public: true, user:)

    @food = Food.first
    @food ||= Food.create(name: 'Salt', measurement_unit: 'gram', price: 1, quantity: 3, user:)

    @ingredient = RecipeFood.first
    @ingredient ||= RecipeFood.create(recipe: @recipe, food: @food, quantity: 1)
  end

  it 'can see the recipe details' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit "/recipes/#{@recipe.id}"
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content(@recipe.description)
    expect(page).to have_content(@recipe.cooking_time)
    expect(page).to have_content(@recipe.preparation_time)
  end

  it 'can see ingredient elements' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit "/recipes/#{@recipe.id}"
    expect(page).to have_content(@ingredient.quantity)
  end

  it 'Btn add ingredient should navigate to new' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit "/recipes/#{@recipe.id}"
    click_button 'Add Ingredient'

    expect(has_current_path?("/recipes/#{@recipe.id}/recipe_foods/new", wait: 5)).to be_truthy
  end

  it 'Btn generate shopping list should navigate to shopping_list' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit "/recipes/#{@recipe.id}"
    click_button 'Generate Shopping List'

    expect(has_current_path?('/general_shopping_list', wait: 5)).to be_truthy
  end
end
