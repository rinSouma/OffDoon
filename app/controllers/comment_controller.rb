class CommentController < ApplicationController
  def create
    get_user_info
    unless @user
      redirect_to root_path
      return
    end
    @comment = Comment.new(comment_params)
    if @comment.save then
      redirect_to home_path(@comment.event_id)
    else
      @comment.errors.full_messages.each do |msg|
        p msg
      end
    end
  end
  
  def destroy
    get_user_info
    unless @user
      redirect_to root_path
      return
    end
    comment = Comment.find(params[:id])
    if comment.uid != @user.uid
      redirect_to root_path
      return
    end
    comment.destroy
    redirect_to home_path(comment.event_id)
  end
  
  private
  def comment_params
    params[:comment].permit(:comment, :event_id, :uid)
  end

end
