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
			save_in @user
			# flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			redirect_to root_path
		end
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password,
			:password_confirmation)
		end
end
