class UserController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:create]

	def info
		if current_user.nil?
			redirect_to root_path
		end
		@user = current_user
	end

	def login
	end

	def show
		@user = current_user
	end

	def create
		user = User.new(user_params)
		if user.save
			sign_in user
			flash[:success] = "欢迎注册ALG.SO，现在您可以发布算法来赚钱了！"
			redirect_to root_path
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
