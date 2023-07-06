class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_food

  validates :user, presence: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_or_equal_to: 0 }
  validates :measurement_unit, presence: true
  validates :quantity, numericality: { greater_or_equal_to: 0 }
end
