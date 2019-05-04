class CartSerializer < ActiveModel::Serializer
	belongs_to :user
  attributes :id, :user_id
end
