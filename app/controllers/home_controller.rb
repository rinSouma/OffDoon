class HomeController < ApplicationController
  def index
    @events = Event.all.order(created_at: 'desc')
    @user = User.find_by(uid: session[:uid])
  end
end
