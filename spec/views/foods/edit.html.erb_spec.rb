require 'rails_helper'

RSpec.describe 'foods/edit', type: :view do
  let(:food) do
    Food.create!(
      name: 'MyString',
      measurement_unit: 'MyString',
      price: '9.99',
      quantity: 1,
      user: nil
    )
  end

  before(:each) do
    assign(:food, food)
  end

  it 'renders the edit food form' do
    render

    assert_select 'form[action=?][method=?]', food_path(food), 'post' do
      assert_select 'input[name=?]', 'food[name]'

      assert_select 'input[name=?]', 'food[measurement_unit]'

      assert_select 'input[name=?]', 'food[price]'

      assert_select 'input[name=?]', 'food[quantity]'

      assert_select 'input[name=?]', 'food[user_id]'
    end
  end
end
