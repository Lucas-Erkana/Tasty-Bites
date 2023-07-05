class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    # Fetches all recipes belonging to the current user
    @recipes = Recipe.where(user: current_user)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    # Retrieves the recipe with associated recipe_food and ingredients
    @recipe = Recipe.includes(:recipe_food).find(params[:id])
    @ingredients = @recipe.recipe_food.where(recipe: @recipe)

    # Redirects to the 'not_accessible' page if the user cannot manage the recipe and the recipe is not public
    redirect_to '/not_accessible' if (cannot? :manage, @recipe) && !@recipe.public
  end

  # GET /recipes/new
  def new
    # Initializes a new recipe object
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    # Renders the edit form for the recipe
  end

  # POST /recipes or /recipes.json
  def create
    # Creates a new recipe object with the submitted parameters
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    # Toggles the public flag of the recipe and saves the changes
    @recipe.public = !@recipe.public
    @recipe.save

    redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.'
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    # Destroys the recipe and its associated recipe_foods
    RecipeFood.destroy_by(recipe: @recipe)
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    # Finds the recipe by its id and redirects to the 'not_found' page if it doesn't exist
    @recipe = Recipe.find_by(id: params[:id])
    redirect_to '/not_found' if @recipe.nil?
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
