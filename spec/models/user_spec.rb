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
