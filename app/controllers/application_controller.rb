class ApplicationController < ActionController::API
    include JWTSessions::RailsAuthorization
    include Rails.application.routes.url_helpers
    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
    helper_method :current_user

    private
        def not_authorized
            render json: { error: "Non autorizer" }, status: :unauthorized
        end
end
