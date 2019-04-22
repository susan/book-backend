class ApplicationController < ActionController::API

  def encode_token(payload)
  	JWT.encode(payload, ENV["SECRET"])
  end

  def auth_header
   request.headers['Authorization']
  end
  #when get routes get decoded token ('the wristband')
  def decoded_token
    if auth_header
  	  token = auth_header.split(" ")[1]
  	  #puts JWT.decode(token, ENV["SECRET"])[0]
      begin
        JWT.decode(token, ENV["SECRET"], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        [{}]
      end
    end
  end



  def curr_user
  	if decoded_token
     user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!curr_user
  end

  def authorized
    redirect_to "/welcome" unless logged_in?
  end



end
