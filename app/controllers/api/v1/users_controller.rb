class Api::V1::UsersController < ApplicationController
  #before_action :find_user, only: [:show]

  # def index
  # end

  # def show
  #   #find_user
  # end

   def create
      @user = User.create(user_params)
          if @user.valid?
            @cart = create_cart(@user)
            @token = encode_token({user_id: @user.id})
            render json: { user: @user, carts: @cart, jwt: @token }, status: :created
          else
            render json: { error: 'failed to create user' }, status: :not_acceptable
          end
    end

  def create_cart(user)
    @cart = Cart.create(user_id: user.id)
  end


  private
  def user_params
  	 params.require(:user).permit(:id, :email, :password)
  end

  # def find_user
  #   @user = User.find(params[:id])
  # end

end
