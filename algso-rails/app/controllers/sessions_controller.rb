# coding: utf-8
class SessionsController < ApplicationController
	def new
	end
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
		else
			flash.now[:error] = '邮箱 / 密码有误'
			render 'user/login'
		end
	end
	def destroy
	end
end
