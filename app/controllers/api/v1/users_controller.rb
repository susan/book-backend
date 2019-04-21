class Api::V1::UsersController < ApplicationController

 before_action :find_user, only: [:show]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    find_user
       render json: @user, status: :ok
   end

   def create
      @user = User.create(user_params)
          if @user.valid?
            create_cart(@user)
          #create_cart(@user.id)
          @token = encode_token({user_id: @user.id})
          render json: { user: @user, jwt: @token }, status: :created
      else
        render json: { error: 'failed to create user' }, status: :not_acceptable
      end
    end

  def create_cart(user)
    @cart = Cart.create(user_id: user.id)
    #@cart = Cart.create(user_id: id)
  end


  private
  def user_params
  	 params.require(:user).permit(:id, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
