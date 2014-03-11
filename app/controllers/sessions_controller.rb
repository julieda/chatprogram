class SessionsController < ApplicationController
  def new
  end

  	def create
  		#session[:username] = params[:username]
  		#render :text => "Welcome #{session[:username]}!"
  		@message = Message.create!(params[:message])
	end

	def index
		@messages = Message.all? 
	end
end
