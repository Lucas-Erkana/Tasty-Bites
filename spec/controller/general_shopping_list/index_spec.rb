require 'rails_helper'
require_relative '../spec_support_helpers'

RSpec.describe GeneralShoppingListController, type: :system do
  before(:all) do
    user = authentificate_test_user

    @recipe = Recipe.first
    @recipe ||= Recipe.create(name: 'Pizza Recipe', description: 'Salt', preparation_time: 10, cooking_time: 3, public: true, user:)

    @food = Food.first
    @food ||= Food.create(name: 'Salt', measurement_unit: 'gram', price: 1, quantity: 3, user:)

    @recipe_food = RecipeFood.first
    @recipe_food = RecipeFood.create(recipe: @recipe, food: @food, quantity: 20)

    @shop_list = RecipeFood.shopping_list(user)
  end

  it 'can see the general_shopping_list index page' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/general_shopping_list'

    expect(page).to have_content('Shopping List')
    expect(page).to have_content('Amount of food items to buy:')
    expect(page).to have_content('Total value of food neeeded:')
  end

  it 'can see the general_shopping_list elements' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/general_shopping_list'

    expect(page).to have_content(@recipe_food.food.name)
    expect(page).to have_content(@shop_list.first.name)
    expect(page).to have_content(@shop_list.first.quantity)
    expect(page).to have_content(@shop_list.first.price)
  end
end
