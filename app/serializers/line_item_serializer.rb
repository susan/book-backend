class LineItemSerializer < ActiveModel::Serializer
	belongs_to :book
  belongs_to :cart
  attributes :id, :quantity, :book_id, :cart_id
end
