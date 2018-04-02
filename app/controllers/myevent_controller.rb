class MyeventController < ApplicationController
  def index
    get_user_info
    unless @user
      redirect_to root_path
      return
    end

    @view_flg = params[:view_flg]
      
    if @view_flg == "true" then
      @view_flg = true
      @events = Event.search(@user, false).includes(:members).where(members: {uid: @user.uid} ).left_joins(:user).order("events.date asc")
    else
      @view_flg = false
      @events = Event.search(@user, true).includes(:members).where(members: {uid: @user.uid} ).left_joins(:user).order("events.date asc")
    end
    
    @join = {}
    @go_astray = {}
    @no_join = {}
    @user_info = {}
    
    @events.each do |event|
      @user_info[event.id] = event.user
      event.members.each do |member|
        if member.kbn == Member.statuses['join'] then
          @join[event.id] = event
        elsif member.kbn == Member.statuses['go_astray'] then
          @go_astray[event.id] = event
        elsif member.kbn == Member.statuses['no_join'] then
          @no_join[event.id] = event
        end
      end      
    end
  end
end
