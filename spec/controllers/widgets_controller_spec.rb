require 'rails_helper'

RSpec.describe WidgetsController, :type => :controller do

  describe "GET Widgets" do
    it "returns http success" do
      get :Widgets
      expect(response).to be_success
    end
  end

end
