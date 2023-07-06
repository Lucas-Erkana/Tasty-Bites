require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
    before(:all) do
        @user = User.first
        @user ||= User.create(name: 'Prantosh')
      
        @food = Food.first
        @food ||= Food.create(name: 'Salt', measurement_unit: 'gram', price: 2, quantity: 3, user: @user)
        @recipe = Recipe.first
        @recipe ||= Recipe.create(name: 'Pasta', preparation_time: 3, cooking_time: 1, description: 'You know how',
                                  public: true, user_id: @user.id)
        @recipe_food = RecipeFood.includes(:food).first
        @recipe_food ||= RecipeFood.create(quantity: 10, food_id: @food.id, recipe_id: @recipe.id)
      end

  it 'Quantity should be present' do
    @recipe_food.quantity = nil
    expect(@recipe_food).to_not be_valid
  end

  it 'test value method' do
    # 10(quantity) x 2 (price) = 20
    expect(@recipe_food.value).to eql 20
  end

  it 'test total_price method' do
    # for only one food total price = 20
    recipe_foods = [@recipe_food]
    expect(RecipeFood.total_price(recipe_foods)).to eql 20
  end

  it 'test shopping list method' do
    shop_list = RecipeFood.shopping_list(@user)
    expect(shop_list.length).to eql 1
    expect(shop_list.first.food.name).to eql @food.name
  end
end
