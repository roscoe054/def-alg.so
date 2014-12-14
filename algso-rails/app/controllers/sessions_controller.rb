require 'rest_client'
require 'json'
# coding: utf-8
class SessionsController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:create, :destroy]

	# get github env config
	if ENV['GITHUB_CLIENT_ID'] && ENV['GITHUB_CLIENT_SECRET']
		CLIENT_ID        = ENV['GITHUB_CLIENT_ID']
		CLIENT_SECRET    = ENV['GITHUB_CLIENT_SECRET']
	else
	 	CLIENT_ID        = "90028819f0c630a62fbc"
	 	CLIENT_SECRET    = "91cb4f1fe152ecfc3db6a9739eab203d3c523900"
	end

	# login
	def new
		# view data
		@client_id = CLIENT_ID

		# github oauth code
		session_code = params[:code] 

		# github user login
		if !session_code.nil? 
			# get access_token
			result = RestClient.post('https://github.com/login/oauth/access_token',
									{:client_id => CLIENT_ID,
									:client_secret => CLIENT_SECRET,
									:code => session_code},
									:accept => :json)
			access_token = JSON.parse(result)['access_token']

			# get user info
			auth_result = JSON.parse(RestClient.get('https://api.github.com/user',
									{:params => {:access_token => access_token},
									:accept => :json}))

			# search user and decide login or save new user
			user = User.find_by(name: auth_result['login'])
			if user
				sign_in_with_github user
				redirect_to user
			else
				user = User.new(:name => auth_result['login'], 
								:email => auth_result['email'],
								:password => CLIENT_SECRET,
								:password_confirmation => CLIENT_SECRET)
				if user.save
					save_in user
					flash[:success] = "欢迎注册ALG.SO，现在您可以发布算法来赚钱了！"
					redirect_to root_path
				else
					flash[:error] = "注册失败，请检查信息是否有效"
					redirect_to root_path
				end
			end
		end
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in (user)
			redirect_to user
		else
			flash.now[:error] = "邮箱 / 密码有误"
			render "new"
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
