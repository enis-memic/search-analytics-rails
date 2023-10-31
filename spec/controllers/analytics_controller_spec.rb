require 'rails_helper'

RSpec.describe AnalyticsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
        get :index
        expect(response).to be_successful
    end
  
    it "assigns @user_queries" do
        user_queries = Query.where(ip_address: "127.0.0.1") # Replace "127.0.0.1" with a valid IP address
        get :index
        expect(assigns(:user_queries)).to match_array(user_queries)
    end
  
    it "renders the :index template" do
        get :index
        expect(response).to render_template("index")
    end
  end
end
  