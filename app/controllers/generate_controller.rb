class GenerateController < ApplicationController
  def index
    get_user_info
    unless @user
      redirect_to root_path
    end
  end
  
  def new
    require 'securerandom'
    token = nil
    loop do
      token = SecureRandom.hex(24)
      p token
      user = User.find_by(token: token)
      if user.nil?
        break
      end
    end
    
    if user = User.find_or_initialize_by(uid: session[:uid])
      user.update_attributes(
        uid: session[:uid],
        token: token
      )
    end
    @user = User.find_by(uid: session[:uid])
    redirect_to generate_index_path
  end
end
