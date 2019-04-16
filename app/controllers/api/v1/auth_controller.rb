class Api::V1::AuthController <ApplicationController
  #login

	def create
      @user = User.find_by(email: login_user_params[:email])
      if @user && @user.authenticate(login_user_params[:password])
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, jwt: token }, status: :accepted
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

    private

   def login_user_params
   	 params.require(:user).permit(:email, :password)
   end



end
