class HomeController < ApplicationController
  PER = 5
  def index
    get_user_info
    @events = Event.search(@user).page(params[:page]).per(PER).left_joins(:user).order("events.created_at desc")
  end
  
  def new
    get_user_info
    @event = Event.new
  end
  
  def show
    get_user_info
    @event = Event.search(@user).left_joins(:user).find(params[:id])
    @members = @event.members.includes(:user).all.order("members.kbn", "members.created_at")
    @member  = @event.members.build(uid: @user.uid) if @user 
    @comments = @event.comments.includes(:user).all.order("comments.created_at")
    @comment = @event.comments.build(uid: @user.uid) if @user 
    @join = {}
    @go_astray = {}
    @no_join = {}
      
    @members.each do |member|
      if member.kbn == Member.statuses['join'] then
        @join[member.id] = member
      elsif member.kbn == Member.statuses['go_astray'] then
        @go_astray[member.id] = member
      elsif member.kbn == Member.statuses['no_join'] then
        @no_join[member.id] = member
      end
    end
  end
  
  def create
    begin
      get_user_info
      insert_event
      redirect_to root_path
    rescue => e
      render action: :new
    end
  end
  
  def edit
    get_user_info
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to home_path(@event.id)
    else
      render action: :edit
    end
  end
  
  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to root_path
  end
  
  private
  def event_params
    params[:event].permit(:title, :detail, :place, :url, :date, :limit, :close_time, :view)
  end
  
  def insert_event
    ActiveRecord::Base.transaction do
      @event = Event.new(event_params)
      @event.uid = @user.uid
      @event.save!
      @member = Member.new()
      @member.uid = @user.uid
      @member.event_id = @event.id
      @member.kbn = Member.statuses['join']
      @member.save!
    end
    rescue => e
      p e
      throw e
  end
end
