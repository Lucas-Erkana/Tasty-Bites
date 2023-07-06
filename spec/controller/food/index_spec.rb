require 'rails_helper'
require_relative '../spec_support_helpers'

RSpec.describe FoodsController, type: :system do
  before(:all) do
    user = authentificate_test_user
    @food = Food.first
    @food ||= Food.create(name: 'Salt', measurement_unit: 'gram', price: 1, quantity: 3, user:)
  end

  it 'can see the food index page' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/foods'

    expect(page).to have_content(@food.name)
    expect(page).to have_content(@food.measurement_unit)
    expect(page).to have_content(@food.price)
    expect(page).to have_content('Remove')
  end

  it 'Btn add food should navigate to new' do
    authentificate_test_user
    expect(page).to have_content('Log Out')
    visit '/foods'
    click_button 'Add Food'

    expect(has_current_path?('/foods/new', wait: 5)).to be_truthy
  end
end
