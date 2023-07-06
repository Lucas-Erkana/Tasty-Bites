require 'rails_helper'
require_relative '../spec_support_helpers'

RSpec.describe PublicRecipesController, type: :system do
  before(:all) do
    user = authentificate_test_user
    @recipe = Recipe.first
    @recipe ||= Recipe.create(name: 'Pizza Recipe', description: 'Salt',
                              preparation_time: 10, cooking_time: 3, public: true, user:)
  end

  it 'can see the public recipe index page with recipe elements' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/public_recipes'
    expect(page).to have_content('Public Recipes')
  end

  it 'can see public recipe elements' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/public_recipes'
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content(@recipe.user.name)
    expect(page).to have_content('Total food:')
    expect(page).to have_content('Total price:')
  end

  it 'Btn add recipe should navigate to recipe details' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/public_recipes'
    click_link @recipe.name

    expect(has_current_path?("/recipes/#{@recipe.id}", wait: 5)).to be_truthy
  end
end
