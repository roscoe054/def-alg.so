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
  	@algs.insert({bundle_name: name, name: name, desc: desc})
  	redirect_to create_path
  end

  def destroy
  end
end
