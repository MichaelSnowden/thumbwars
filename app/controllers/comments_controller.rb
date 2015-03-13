class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.save
    @comments = Comment.all
  end
  def new
    @comment = Comment.new
  end
  private
    def comment_params
      params.require(:comment).permit(:content, :user_id, :commentable_type, :commentable_id)
    end
end