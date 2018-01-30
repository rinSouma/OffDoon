class HomeController < ApplicationController
  def index
    @events = Event.all.order(created_at: 'desc')
    get_user_info
  end
  
  def new
    get_user_info
    @event = Event.new
  end
  
  def show
    redirect_to root_path
    get_user_info
  end
  
  def create
    get_user_info

    @event = Event.new(event_params)
    @event.uid = @user.uid
      
    p @event
    
    if @event.save
      p @event
      redirect_to root_path
    else
      p @event.errors
      render action: :new
    end
  end
  
  private
  def event_params
    params[:event].permit(:title, :detail, :place, :url, :date, :limit, :close_time, :view)
  end
  
end
