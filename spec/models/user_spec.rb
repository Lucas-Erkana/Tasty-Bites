<<<<<<< HEAD
require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.first
    @user ||= User.create(name: 'Lucas')
  end

  it 'should have a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end
end
=======
rspec spec/models/recipe_spec.rb
>>>>>>> ae7d5ea25b52c7b2b9abcf823b54ebe477d9b038
