class ApplicationController < ActionController::API
    include ActionController::Cookies
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :authenticate_user!
   
    private

    def authenticate_user!
        token = cookies.signed['jwt']
        begin
            decoded_token = JWT.decode(token, JWT_SECRET_KEY, true, algorithm: 'HS256')[0]
            user_id = decoded_token['user_id']
            @current_user = User.find(user_id)
        rescue JWT::DecodeError, JWT::VerificationError, JWT::ExpiredSignature
            render json: { error: 'Invalid token' }, status: :unauthorized
        rescue ActiveRecord::RecordNotFound
            render json: { error: 'User not found' }, status: :unauthorized
        end
        puts "The authentication is running fine"
    end
    
    def current_user
        @current_user
    end

     
    def revoke_token(token_id)
      current_user.jwt_denylist.create(jti: token_id, exp: Time.now)
      cookies.delete(:jwt)
    end
  

    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
        end

end
