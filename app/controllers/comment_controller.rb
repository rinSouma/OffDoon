class CommentController < ApplicationController
  def create
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
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to home_path(comment.event_id)
  end
  
  private
  def comment_params
    params[:comment].permit(:comment, :event_id, :uid)
  end

end
