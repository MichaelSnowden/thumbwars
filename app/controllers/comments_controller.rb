class CommentsController < ApplicationController
  respond_to :html, :js
  before_action :set_comment, only: [:show, :like, :dislike, :unlike, :undislike]
  before_action :authenticate_user!
  before_action :authenticate_owner!, only: [:edit, :destroy]

  def authenticate_owner!
    unless current_user == @comment.user
      flash[:error] = "You don't own this comment"
      redirect_to new_user_session_path
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @comments = @comment.post.comments.order('created_at desc').select { |c| c.root? == true }
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :json => @comment, :status => :ok
    else
      render :js => "alert('error deleting comment');"
    end
  end

  def like
    @comment.liked_by current_user
    respond_to do |f|
      f.js {}
    end
  end

  def dislike
    @comment.downvote_from current_user
    respond_to do |f|
      f.js {}
    end
  end

  def unlike
    @comment.unliked_by current_user
    respond_to do |f|
      f.js {}
    end
  end

  def undislike
    @comment.undisliked_by current_user
    respond_to do |f|
      f.js {}
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end
    def comment_params
      params.require(:comment).permit(:parent_id, :bootsy_image_gallery_id, :post_id, :content, :user_id)
    end
end