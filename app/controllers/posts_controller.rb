class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(%i[author post])
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

  def destroy
    Authorize! :destroy, @post
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
