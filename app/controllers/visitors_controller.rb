class VisitorsController < ApplicationController
    def index
        if user_signed_in?
            redirect_to userdata_path
        end
    end
end
