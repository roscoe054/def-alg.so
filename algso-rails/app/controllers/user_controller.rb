class UserController < ApplicationController
	def info
		@user = current_user
	end

	def login
	end

	def show
		@user = current_user
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			cookies.permanent[:newtest_remember_token] = "remember_token"
			redirect_to @user
		else
			render 'new'
		end
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password,
			:password_confirmation)
		end
end
