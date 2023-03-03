class Api::V1::AuthController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :authenticate_user!, only: [:sign_out]
  
    # POST /auth/sign_up
    def sign_up
      @user = User.new(sign_up_params)
      if @user.save
        cookies.signed[:jwt] = { value: JWT.encode({ user_id: @user.id, jti: SecureRandom.uuid }, JWT_SECRET_KEY), httponly: true }
        render json: { status: :created, user: @user , message: 'User created successfully'}
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # POST /auth/sign_in
    def sign_in
      @user = User.find_by_email(params[:email])
  
      if @user&.valid_password?(params[:password])
        cookies.signed[:jwt] = { value: JWT.encode({ user_id: @user.id, jti: SecureRandom.uuid }, JWT_SECRET_KEY), httponly: true }
        render json: { status: :ok, user: @user }
      else
        render json: { errors: ['Invalid email or password'] }, status: :unauthorized
      end
    end
  
    # DELETE /auth/sign_out
    def sign_out
        token = cookies.signed[:jwt]
        if token.present?
          payload = JWT.decode(token, JWT_SECRET_KEY, true, { algorithm: 'HS256' })[0]
          jti = payload['jti']
          puts "This is jti #{jti}"
          revoke_token(jti)
          render json: { status: :ok, message: 'Signed out successfully' }
        else
          render json: { errors: ['No token found in cookies'] }, status: :unprocessable_entity
        end
    end

    def update
        current_user = User.find(params[:user_id])
        # current_user.username = params[:username] if params[:username].present?
        byebug
        if current_user.update(update_params)
            current_user.user_image.attach(params[:image]) if params[:image].present? # Attach the image if present
            render json: current_user.as_json(methods: :image_url), status: :ok
        else
          render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
        end
    end
  

    private
  
    def sign_up_params
        params.require(:auth).permit(:username, :email, :password, :password_confirmation)
    end

    def update_params
        # params.permit(:username, :email, :image, :user_id).merge(password: params.require(:password))
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    # def store_token(token)
    #     cookies.signed[:jwt] = { value: token, httponly: true, expires: 24.hour.from_now }
    # end

  end
  