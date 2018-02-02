class MemberController < ApplicationController
  def create
    
    
    member = Member.find_or_initialize_by(event_id: params[:member][:event_id], uid: params[:member][:uid])
    member.update_attributes(member_params)
    redirect_to home_path(member.event_id)
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to home_path(comment.event_id)
  end
  
  private
  def member_params
    params[:member].permit(:kbn, :event_id, :uid)
  end
end
