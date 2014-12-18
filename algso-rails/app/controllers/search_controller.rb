# coding: utf-8
class SearchController < ApplicationController
  def index
  	# connection
	coll = MongoClient.new("localhost", 27017).db("algso_dev")["alg_info"]
	
  end
end
