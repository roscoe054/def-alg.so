require 'rails_helper'
require 'spec_helper'

RSpec.describe SessionsController do
  describe "GET new" do
    it "has a 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(assigns(:client_id)).to eql('90028819f0c630a62fbc')
    end

    # pending "need to test github signup/login"
  end

  describe "GET create" do
		#prepare a user in db

    it "should login" do
	  	user = FactoryGirl.create(:user)
      post :create, {'email' => 'test@email.com', 'password' => 'test_password'}
      parsed_body = JSON.parse(response.body)
			expect(parsed_body["req"]).to eql "success"
    end

    it "shouldn't login with wrong_password" do
    	user = FactoryGirl.create(:user)
      post :create, {'email' => 'test@email.com', 'password' => 'wrong_password'}
      parsed_body = JSON.parse(response.body)
			expect(parsed_body["req"]).to eql "error"
    end

    it "shouldn't login with not exist email" do
    	user = FactoryGirl.create(:user)
      post :create, {'email' => 'no@email.com', 'password' => 'test_password'}
      parsed_body = JSON.parse(response.body)
			expect(parsed_body["req"]).to eql "error"
    end
  end

  describe "GET destroy" do
    it "redirect_to root_path and delete remember_token cookie" do
      get :destroy
      expect(response).to redirect_to root_path
      expect(response.cookies['remember_token']).to be_nil
    end
  end
end