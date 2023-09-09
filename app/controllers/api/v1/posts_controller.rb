class Api::V1::PostsController < ApplicationController
  def index
    posts = User.find(params[:user_id]).posts
    render json: posts, status: 200
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to user_posts_path(user_id: current_user.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @post.destroy
    @user.posts_counter -= 1
    @user.save
    redirect_to user_path(@user.id), notice: 'Post deleted successfully.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
