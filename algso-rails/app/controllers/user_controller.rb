require 'json'
# coding: utf-8
class UserController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:create]

	def show
		current_user = User.find_by(name_id: params[:name_id])
		if !current_user.nil?
			@user = current_user
			if current_user.avatar.nil?
				current_user.avatar = current_user.gravatar_url(:s => 200)
			end
		else
			redirect_to root_path #TODO redirect_to 404 page
		end
	end

	def create
		user = User.new(user_params)
		saveInfo = save_in user
		render json: JSON.generate(saveInfo)
	end

	private
		def user_params
			params.permit(:name, :email, :password, :password_confirmation)
		end
end
