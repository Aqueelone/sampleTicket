require 'rails_helper'

RSpec.describe DashboardController, :type => :controller do

  describe "GET Dashboard" do
    it "returns http success" do
      get :Dashboard
      expect(response).to be_success
    end
  end

end
