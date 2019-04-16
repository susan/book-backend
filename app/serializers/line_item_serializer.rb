class LineItemSerializer < ActiveModel::Serializer
	belongs_to :book
  belongs_to :cart
  attributes :id
end
