class HomeController < ApplicationController
  PER = 5
  def index
    get_user_info
    @sorts_data = {"作成が新しい順"=>0,"作成が古い順"=>1,"開催日が早い順"=>2,"開催日が遅い順"=>3,"回答期限が近い順"=>4}
    @sort_key = params[:sort]
    @sort_key = 0 if @sort_key.blank?
    case @sort_key
    when "1" then
      order = "events.created_at asc"
    when "2" then
      order = "events.date asc"
    when "3" then
      order = "events.date desc"
    when "4" then
      order = "events.close_time >= ? desc, events.close_time asc"
    else
      order = "events.created_at desc"
    end
    if @sort_key == "4" then
      @events = Event.search(@user, true).page(params[:page]).per(PER).left_joins(:user).order([order, DateTime.now])
    else
      @events = Event.search(@user, true).page(params[:page]).per(PER).left_joins(:user).order(order)
    end
  end
  
  def new
    get_user_info
    unless @user
      redirect_to root_path
      return
    end
    @event = Event.new
  end
  
  def show
    get_user_info
    begin
      @event = Event.search(@user, false).left_joins(:user).find(params[:id])
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
    rescue=>e
      redirect_to root_path
    end
  end
  
  def create
    begin
      get_user_info
      insert_event
      #トゥートするかしないかチェックボックス判定
      if params['toot']
        url = request.url
        message = "OffDoonでイベントを作成しました。\n「#{@event.title}」\n#{url}/#{@event.id}"
        toot_for_mastodon(message)
      end
      redirect_to root_path
    rescue => e
      render action: :new
    end
  end
  
  def edit
    get_user_info
    unless @user
      redirect_to root_path
      return
    end
    @event = Event.find(params[:id])
    if @event.uid != @user.uid
      redirect_to root_path
      return
    end
  end
  
  def update
    get_user_info
    unless @user
      redirect_to root_path
      return
    end
    @event = Event.find(params[:id])
    if @event.uid != @user.uid
      redirect_to root_path
      return
    end
    @event.updated_at = Time.now

    #未定チェックがあれば開催日は2999/12/31
    e_params = event_params
    if params['undecided']
      temp = DateTime.now
      @event.date = DateTime.new(2999, 12, 31, 23, 59, 59, temp.offset)
    end
    if @event.update_attributes(event_params)
      if params['toot']
        url = request.url
        message = "OffDoonのイベントを編集しました。\n「#{@event.title}」\n#{url}"
        toot_for_mastodon(message)
      end
      redirect_to home_path(@event.id)
    else
      render action: :edit
    end
  end
  
  def destroy
    get_user_info
    unless @user
      redirect_to root_path
      return
    end
    event = Event.find(params[:id])
    if event.uid != @user.uid
      redirect_to root_path
      return
    end
    event.destroy
    redirect_to root_path
  end
  
  private
  def event_params
    if params['undecided']
      params[:event].permit(:title, :detail, :place, :url, :limit, :close_time, :view)
    else
      params[:event].permit(:title, :detail, :place, :url, :date, :limit, :close_time, :view)
    end
  end
  
  def insert_event
    ActiveRecord::Base.transaction do
      @event = Event.new(event_params)
      #未定チェックがあれば開催日は2999/12/31
      if params['undecided']
        temp = DateTime.now
        @event.date = DateTime.new(2999, 12, 31, 23, 59, 59, temp.offset)
      end
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
