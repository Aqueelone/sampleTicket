require 'rails_helper'

RSpec.describe EventController, :type => :controller do

  describe "GET Event" do
    it "returns http success" do
      get :Event
      expect(response).to be_success
    end
  end

end
