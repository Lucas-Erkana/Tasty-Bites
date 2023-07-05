class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_food

  validates :name, presence: true
  validates :preparation_time, numericality: { only_integer: true, greater_or_equal_to: 0 }
  validates :cooking_time, numericality: { only_integer: true, greater_or_equal_to: 0 }
  validates :description, presence: true
  validates :public, inclusion: { in: [true, false], message: 'should be a boolean value' }
end
