require 'rails_helper'

RSpec.describe User, type: :model do
<<<<<<< Updated upstream
  pending "add some examples to (or delete) #{__FILE__}"
=======
  before(:all) do
    @user = User.first
    @user ||= User.create(name: 'Oscar')
  end

  it 'should have a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end
>>>>>>> Stashed changes
end
