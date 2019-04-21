class Book < ApplicationRecord
  has_many :carts, through: :line_items, dependent: :destroy
  validates_uniqueness_of :title
end
