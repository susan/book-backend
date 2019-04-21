class User < ApplicationRecord
	has_many :carts, dependent: :destroy
	has_secure_password
end
