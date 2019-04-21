class LineItemSerializer < ActiveModel::Serializer
	belongs_to :book
  belongs_to :cart
  attributes :id, :cart_id, :book_id
end
