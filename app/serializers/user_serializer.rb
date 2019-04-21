class UserSerializer < ActiveModel::Serializer
	#has_many :carts
  attributes :email, :password
  #put password in here so user can change it via tokenattributes :id
  #


end
