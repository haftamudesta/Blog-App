class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.includes(:author).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save!
      redirect_to user_posts_path(current_user)
    else
      render :new, alert: 'An error has occurred while creating the post'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
