class PostsController < ApplicationController
  def index
    @posts = @user.posts.order(created_at: :asc)
  end

  def show
    @post = @user.post.find(params[:id])
  end
end
