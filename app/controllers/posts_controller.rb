class PostsController < ApplicationController

  respond_to :html, :js
  before_action :set_posts, only: [:index, :create, :update, :delete, :destroy]
  before_action :set_post, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :delete, :destroy]
  
  def index
  end

  def show
    @comments = @post.comments.order('created_at desc').select { |c| c.root? == true }
    @comment = Comment.new
    @comment.user_id = current_user.id
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
      @posts = Post.all.order('created_at desc')
    end
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :root_comments => [])
    end
end