class Api::V1::AuthController <ApplicationController
  def create 
    @user = User.find_by(email: login_user_params[:email])
      if @user && @user.authenticate(login_user_params[:password])
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, line_items: @user.cart.line_items, cart_items: @user.cart.books, jwt: token }, status: :accepted
      else
        render json: { message: 'Invalid email or password' }, status: :unauthorized
      end
    end

  def show
    @user = curr_user  
    if @user
      render json: { user: @user, line_items: @user.cart.line_items, cart_items: @user.cart.books }, status: :accepted
    else
      render json: { message: 'not logged in' }, status: :unauthorized
    end
  end

  private

  def login_user_params
   	params.require(:user).permit(:id, :email, :password)
  end

end
