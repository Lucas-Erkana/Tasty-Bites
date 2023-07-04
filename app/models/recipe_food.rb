class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { greater_or_equal_to: 0 }

  # recipe_food should include (foods, recipes)
  def value
    return 'no food error' unless food

    food.price * quantity
  end

  def self.total_price(recipe_foods)
    recipe_foods.reduce(0) { |sum, recipe_food| sum + recipe_food.value }
  end

  def self.shopping_list(user)
    recipe_foods = RecipeFood.joins(:food)
      .select('recipe_foods.food_id, foods.name, foods.price, SUM(recipe_foods.quantity) as quantity')
      .group('recipe_foods.food_id, foods.name, foods.price')

    user_foods = Food.where(user:)

    shop_list = []
    recipe_foods.each do |recipe_food|
      food = user_foods.select { |el| el.id == recipe_food.food_id }
      if food.length == 1
        food = food[0]
        recipe_food.quantity -= food.quantity if food
        recipe_food.price *= recipe_food.quantity

        shop_list << recipe_food if recipe_food.quantity.positive?
      else
        shop_list << recipe_food
      end
    end
    shop_list
  end
end
