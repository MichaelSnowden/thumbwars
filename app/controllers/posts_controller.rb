class PostsController < ApplicationController

  respond_to :html, :js
  before_action :set_posts, only: [:index, :create, :update, :delete, :destroy]
  before_action :set_post, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :delete, :destroy]
  
  def index
  end

  def show
    @comment = Comment.new
    @commentable_id = @post.id
    @commentable_type = "Post"
    @comments = @post.comment_threads
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
  end

  def edit

  end

  def update
    @post.update_attributes(post_params)
  end

  def delete
    @post = Post.find(params[:post_id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
    def set_posts
      @posts = Post.all
    end
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :root_comments => [])
    end
end