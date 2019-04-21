class Api::V1::AuthController <ApplicationController
  #login

	def create
      @user = User.find_by(email: login_user_params[:email])
      @cart = Cart.find_by(:user_id => @user.id)
      @cart_items = cart_items(@cart)
      #byebug
      if @user && @user.authenticate(login_user_params[:password])
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, cart_items: @cart_items, jwt: token }, status: :accepted
      else
        render json: { message: 'Invalid email or password' }, status: :unauthorized
      end
    end

  def show
    @user = curr_user
    #renamed from current_user because active model
    if @user
        render json: { user: @user}, status: :accepted
      else
        render json: { message: 'Invalid email or password' }, status: :unauthorized
      end
    end

 def cart_items(cart)
    @items = LineItem.all.select do |item|
        item.cart_id === cart.id
    end
    @books = @items.map do |item|
      item.book
    end
    @books
 end

    private

   def login_user_params
   	 params.require(:user).permit(:email, :password)
   end



end
