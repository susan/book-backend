class Book < ApplicationRecord
  belongs_to :user
	has_many :line_items
  has_many :carts, through: :line_items, dependent: :destroy
  validates_uniqueness_of :title
end
