class PostsController < ApplicationController

  respond_to :html, :js
  before_action :set_posts, only: [:index, :update, :delete, :destroy]
  before_action :set_post, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :delete, :destroy]
  
  def index
    @post = Post.new
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
    @tag = @post.tag_list[0]
    @posts = Post.tagged_with(@tag).order('created_at desc')
    puts "POSTS FROM CONTROLLER: " + @posts.all.inspect
  end

  def tagged
    @tag = params[:tag]
    @posts = Post.tagged_with(@tag).order('created_at desc')
  end

  def all
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