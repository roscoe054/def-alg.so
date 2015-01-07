module SessionsHelper
	def sign_in(user)
		remember_token = User.new_remember_token
		rememberPwd = params[:remember]
		if rememberPwd == "on"
			cookies.permanent[:remember_token] = remember_token
		else
			cookies[:remember_token] = remember_token
		end
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
		puts self.current_user
	end

	def sign_in_with_github(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def save_in(user)
		if user.save
			remember_token = User.new_remember_token
			cookies[:remember_token] = remember_token
			user.update_attribute(:remember_token, User.encrypt(remember_token))
			self.current_user = user

			# get same username records count, and set user_id
			sameNameUsersCount = User.count(:conditions => "name == '" + user.name + "'")
			if(sameNameUsersCount == 1)
				user.update_attribute(:name_id, user.name)
			else
				user.update_attribute(:name_id, user.name + '-' + sameNameUsersCount.to_s)
			end
			
			returnInfo = {"req" => "success", "err" => "", "info" => "欢迎注册ALG.SO，现在您可以发布算法来赚钱了！"}
		else
			returnInfo = {"req" => "error", "err" => "", "info" => "注册失败，请检查信息是否填写完整"} 
		end
		
		return returnInfo
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end
end
