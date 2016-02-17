require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  login_user
  describe "GET #index" do
    before(:each) do 
      user = FactoryGirl.create(:user_with_images)
    end

    it "return one image on json format for the defined boundingbox" do
      get :index, format: :json , :coordinates => "-104.665291878125,2.832564780389027,-63.510506721875004,16.86691268863375"
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(1)
    end
  end
end
