class Cart < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :books, through: :line_items
end
