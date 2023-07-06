class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @foods = Food.where(user: current_user)
    @recipe = Recipe.find(params[:recipe_id])
  end

  def show; end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe = Recipe.find(params[:recipe_id])
    @recipe_food.food = Food.find(params[:recipe_food][:id])

    if @recipe_food.save
      redirect_to recipe_path(@recipe_food.recipe_id), notice: 'Ingredient has been added successfully!'

    else
      redirect_to recipe_path(@recipe_food.recipe_id), notice: 'Error Happened'
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_url(params[:recipe_id]), notice: 'Ingredient was successfully destroyed.'
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @foods = Food.where(user: current_user)
    @recipe = Recipe.find(params[:recipe_id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.update(recipe_food_params)
    redirect_to recipe_path(@recipe_food.recipe_id), notice: 'Ingredient was successfully updated.'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity)
  end
end
