class SigninController < ApplicationController
    before_action  :authorize_access_request!, only: [:destroy]

    def create
        user = User.find_by!(email: params[:email])

        if user.authenticate(params[:password])
            payload = { user_id: user.id, role: user.user_type }
            session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
            tokens = session.login   
            render json: {id: user.id, email: user.email, role: user.user_type, csrf: tokens[:access] }
        else
            not_found
        end
    end

    def destroy
        session = JWTSessions::Session.new(payload: payload)
        session.flush_by_access_payload
        render json: :ok
    end


    private

    def not_found
        render json: { error: "mail ou password erroné"}, status: :not_found
    end
end