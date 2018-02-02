class HomeController < ApplicationController
  def index
    @events = Event.left_joins(:user).select("users.*, events.*").order("events.created_at desc")
    get_user_info
  end
  
  def new
    get_user_info
    @event = Event.new
  end
  
  def show
    get_user_info
    @event = Event.left_joins(:user).find(params[:id])
    @members = @event.members.includes(:user).all.order("members.kbn", "members.created_at")
    @member  = @event.members.build(uid: @user.id) if @user 
    @comments = @event.comments.includes(:user).all.order("comments.created_at")
    @comment = @event.comments.build(uid: @user.id) if @user 
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
