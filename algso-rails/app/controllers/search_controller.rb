# coding: utf-8
class SearchController < ApplicationController
  def index
  	# connection
	connect_mongodb()
	@algs_list = @algs.find()
  end
end
