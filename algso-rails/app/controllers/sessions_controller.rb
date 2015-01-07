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

	# login/signup with github
	def new
		# set view data
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
			user = User.find_by(email: auth_result['email'])
			if user
				sign_in_with_github user
				redirect_to :controller=>'user', :action => 'show', :name_id => user['name_id']
			else
				user = User.new(:name => auth_result['login'],
								:email => auth_result['email'],
								:avatar => auth_result['avatar_url'],
								:password => CLIENT_SECRET,
								:password_confirmation => CLIENT_SECRET)

				saveInfo = save_in user

				#req 可能为success或error
				flash[saveInfo['req']] = saveInfo['info']

				redirect_to root_path
			end
		end
	end

	def create
		user = User.find_by(email: params[:email].downcase)
		if user && user.authenticate(params[:password])
			sign_in (user)
			render json: {"req" => "success", "err" => "", "name_id" => user.name_id}
		else
			render json: {"req" => "error", "err" => "auth fail", "info" => "用户名/密码有误"}
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
