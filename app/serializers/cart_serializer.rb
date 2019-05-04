class CartSerializer < ActiveModel::Serializer
	belongs_to :user
	has_many :line_items
	has_many :books, through: :line_items
  attributes :id, :user_id
end
