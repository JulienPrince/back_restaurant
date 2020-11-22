class SignupController < ApplicationController
  
    def create
          user = User.new(user_params)
          if user.save
            payload = { user_id: user.id, role: user.user_type }
            session = JWTSessions::Session.new(payload: payload)
            tokens = session.login
            render json: {id: user.id, role: user.user_type, csrf: tokens[:access] }
          else
            render json: {errors: user.errors.full_messages.join(', ')}, status: :unprocessable_entity
          end
      end
  
    private
      def user_params
        params.permit(:user_type, :email, :password, :password_confirmation)
      end
  end
  