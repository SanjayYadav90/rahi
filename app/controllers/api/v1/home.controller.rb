require 'pry'
class HomeController < ApplicationController
  def index
  	@post = Home.new(params[:post])
  	@post.user_id = current_user.id
  	@post.current_location = params[:origin_point]
  	@post.destination_location = params[:destination_point]
  	binding.pry

	  respond_to do |format|
	    if @post.save
	      format.html  { redirect_to('/home/show',
	                    :notice => 'Post was successfully created.') }
	      format.json  { render :json => @post,
	                    :status => :created, :location => @post }
	    else
	      format.html  { render :action => "index" }
	      format.json  { render :json => @post.errors,
	                    :status => :unprocessable_entity }
	    end
	  end
  end
  def show
  	
  end

  def new
    @post = Home.new
  end
end
