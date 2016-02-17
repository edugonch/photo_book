require 'rails_helper'

describe "search image by point" do
  fixtures :all
  before(:each) do 
    user = FactoryGirl.create(:user_with_images)
  end

  it "should have at least one image at thise coordinates" do
      visit images_path(lat: "9.924824", lng: "-84.087899")
      expect(response).to have_http_status(:success)
      puts "response.body #{response.body}"
      expect(page).to have_css(".thumbnail")
      expect(page).to have_content("This is the test description")
  end
  it "should have at least one image when search for tags" do
      visit search_path(tags: ["animals", "japan"])
      expect(response).to have_http_status(:success)
      expect(page).to have_css(".thumbnail")
      expect(page).to have_content("This is the test description")
  end
end