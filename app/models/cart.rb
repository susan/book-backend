class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items
  has_many :books, through: :line_items, dependent: :destroy
end
