class ApplicationController < ActionController::Base
    # protect_from_forgery with: :exception
    protect_from_forgery prepend: true
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def get_ratings
        ["1", "2", "3", "4", "5"]
    end

    helper_method :get_ratings

end
