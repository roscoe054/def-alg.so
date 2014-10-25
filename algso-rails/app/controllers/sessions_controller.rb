# coding: utf-8
class SessionsController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:create, :destroy]
	
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to info_path
		else
			flash.now[:error] = '邮箱 / 密码有误'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
