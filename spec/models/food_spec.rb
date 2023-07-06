require 'rails_helper'

RSpec.describe Food do
  before(:all) do
    @user = User.first
    @user ||= User.create(name: 'Lucas')
    @food = Food.first
    @food ||= Food.create(name: 'Salt', measurement_unit: 'gram', price: 1, quantity: 3, user: @user)
  end

  it 'should have a name' do
    @food.name = nil
    expect(@food).to_not be_valid
  end

  it 'should have a measurement_unit' do
    @food.measurement_unit = nil
    expect(@food).to_not be_valid
  end

  it 'should have a price' do
    @food.price = nil
    expect(@food).to_not be_valid
  end

  it 'should have a quantity' do
    @food.quantity = nil
    expect(@food).to_not be_valid
  end

  it 'should have a user' do
    @food.user = nil
    expect(@food).to_not be_valid
  end
end
