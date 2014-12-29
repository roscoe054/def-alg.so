# coding: utf-8
class SearchController < ApplicationController
  def index
  	# connection
	connect_mongodb()
  # if params[:keyword].nil? or params[:keyword].blank?
  #   params[:keyword] = "分词"
  # end
	@algs_list = @algs.find({'$or'=>[{name:/#{params[:keyword]}/},{desc:/#{params[:keyword]}/}]})
  end
end
