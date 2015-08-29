class PostsController < ApplicationController

  respond_to :html, :js
  before_action :set_posts, only: [:update, :delete, :destroy]
  before_action :set_post, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :delete, :destroy]
  
  def index
    @post = Post.new
    if params[:search]
      search
    else
      set_posts
    end
  end

  def search
    @search = params[:search]
    @posts = Post.search(@search).order("created_at DESC")
  end

  def show
    @comments = @post.comments.order('created_at desc').select { |c| c.root? == true }
    return unless current_user
    @comment = Comment.new
    @comment.user_id = current_user.id
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      @tag = @post.tag_list[0]
      @posts = Post.tagged_with(@tag).order('created_at desc')
    end
  end

  def tagged
    session[:tag] = params[:tag]
    @posts = Post.tagged_with(params[:tag]).order('created_at desc')
  end

  def all
    session[:tag] = nil
    @posts = Post.all.order('created_at desc')
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
      params.require(:post).permit(:title, :bootsy_image_gallery_id, :content, :user_id, :tag_list)
    end
end