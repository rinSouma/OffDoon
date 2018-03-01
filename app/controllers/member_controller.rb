class MemberController < ApplicationController
  def create
    if params[:member][:limit] then
      if params[:member][:limit].to_i < params[:member][:count].to_i + 1 then
        redirect_to home_path(params[:member][:event_id])
        return
      end
    end
    
    member = Member.find_or_initialize_by(event_id: params[:member][:event_id], uid: params[:member][:uid])
    member.update_attributes(member_params)
    redirect_to home_path(member.event_id)
  end
  
  def destroy
    member = Member.find(params[:id])
    member.destroy
    redirect_to home_path(member.event_id)
  end
  
  private
  def member_params
    params[:member].permit(:kbn, :event_id, :uid)
  end
end
