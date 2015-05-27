require 'rails_helper'

RSpec.describe GuideController, :type => :controller do

  describe "GET Guide" do
    it "returns http success" do
      get :Guide
      expect(response).to be_success
    end
  end

end
