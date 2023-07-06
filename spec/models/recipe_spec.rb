require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject do
    @user = User.create(name: 'Lucas')
    @recipe = Recipe.create(name: 'Chicken Biryani', preparation_time: 4, cooking_time: 5, description: 'How to cook chicken biryani',
                            public: true, user_id: @user.id)
  end

  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Name should have valid value' do
    expect(subject.name).to eql 'Chicken Biryani'
  end

  it 'Preparation time should be present' do
    subject.preparation_time = nil
    expect(subject).to_not be_valid
  end

  it 'Preparation time should be an integer' do
    expect(subject.preparation_time).to be_an(Integer)
  end

  it 'Preparation time should not be less than 1' do
    subject.preparation_time = -1635
    expect(subject).to_not be_valid
  end

  it 'Preparation time should have valid value' do
    expect(subject.preparation_time).to eql 4
  end

  it 'Cooking time should be present' do
    subject.cooking_time = nil
    expect(subject).to_not be_valid
  end

  it 'Cooking time should be an integer' do
    expect(subject.cooking_time).to be_an(Integer)
  end

  it 'Cooking time must not be less than 1' do
    subject.cooking_time = -1321
    expect(subject).to_not be_valid
  end

  it 'Cooking time should have valid value' do
    expect(subject.cooking_time).to eql 5
  end

  it 'Description should be present' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'Description should have valid value' do
    expect(subject.description).to eql 'How to cook chicken biryani'
  end

  it 'Public should be a boolean' do
    expect(subject.public).to be(false).or be(true)
  end

  it 'Public should have valid value' do
    expect(subject.public).to eql true
  end
end
