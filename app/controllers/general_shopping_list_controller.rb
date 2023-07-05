class GeneralShoppingListController < ApplicationController
  def index
    @shop_list = RecipeFood.shopping_list(current_user)

    @total_price = @shop_list.reduce(0) { |sum, el| sum + el.price }
  end
end
