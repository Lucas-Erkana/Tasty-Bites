require 'rails_helper'
require_relative '../spec_support_helpers'

RSpec.describe RecipeFoodsController, type: :system do
  before(:all) do
    user = authentificate_test_user
    @recipe = Recipe.first
    @recipe ||= Recipe.create(name: 'Pizza Recipe', description: 'Salt',
                              preparation_time: 10, cooking_time: 3, public: true, user:)
    @food = Food.first
    @food ||= Food.create(name: 'Salt', measurement_unit: 'gram', price: 1, quantity: 3, user:)
    @ingredient = RecipeFood.where(recipe: @recipe, food: @food).first
    @ingredient ||= RecipeFood.create(recipe: @recipe, food: @food, quantity: 1)
  end

  it 'can see the add ingrediant page' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit "/recipes/#{@recipe.id}/recipe_foods/new"
    expect(page).to have_content('Add Ingrediants')
  end

  it 'can submit form' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit "/recipes/#{@recipe.id}/recipe_foods/new"
    fill_in 'recipe_food[quantity]', with: 2
    click_button 'Create Recipe food'
    expect(has_current_path?("/recipes/#{@recipe.id}", wait: 5)).to be_truthy
    expect(page).to have_content('2')
  end
end
