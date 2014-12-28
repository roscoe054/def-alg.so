# coding: utf-8
class AlgInfoController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def create
  	connect_mongodb()
  	name = params[:name]
  	desc = params[:desc]
    user_id = params[:user_id]
    user_name = params[:user_name]
  	@algs.insert(
      {
        bundle_name: name, 
        name: name, 
        desc: desc,
        user_id: user_id,
        user_name: user_name,
        created_at: Time.now(),
        updated_at: Time.now()
      })
  	redirect_to search_path
  end

  def destroy
  end
end
