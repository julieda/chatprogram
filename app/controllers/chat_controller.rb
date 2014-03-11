class ChatController < ApplicationController

def room
  redirect_to login_path unless session[:email]
end
end
