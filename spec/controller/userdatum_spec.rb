require 'rails_helper'

RSpec.describe UserdataController, type: :controller do

    before(:each) do
        @userdata = Userdatum.new
        @userdata.name = 'test name'
        @userdata.comment = 'test comment'
        @userdata.user_id = 5
        @userdata.place_id = '10'
    end

    it 'should show index page' do
        get :index
        assert_response :success
    end
end