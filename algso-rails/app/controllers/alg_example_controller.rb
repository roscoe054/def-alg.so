class AlgExampleController < ApplicationController
  def alg1

  	@result = []

  	params[:in] = JSON.parse(params[:in]) rescue nil

  	@result = params[:in].sort() if params[:in]

  	respond_to do |format|
  	  format.html
  	  format.xml  { render :xml => @result }
  	  format.json { render :json => @result }
  	end
  end
end
