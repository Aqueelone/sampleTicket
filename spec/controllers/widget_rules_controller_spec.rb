require 'rails_helper'

RSpec.describe WidgetRulesController, :type => :controller do

  describe "GET WidgetRules" do
    it "returns http success" do
      get :WidgetRules
      expect(response).to be_success
    end
  end

end
