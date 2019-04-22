class User < ApplicationRecord
	has_one :cart, dependent: :destroy
	has_secure_password
end
