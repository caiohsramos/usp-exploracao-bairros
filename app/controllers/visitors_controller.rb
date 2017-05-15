class VisitorsController < ApplicationController
    def index
        if user_signed_in?
            redirect_to userdata_path(:user_id => current_user.id)
        end
    end
end
