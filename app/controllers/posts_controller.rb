class PostsController < ApplicationController
  def index
    @posts = @user.posts.order(created_at: :asc)
  end

  def show
    @post = @user.post.find(params[:id])
  end

  # def new
  #   @post = Post.new
  # end

  # def create
  #   @post = Post.new(post_params)
  #   if @post.save
  #     redirect_to @post
  #   else
  #     render 'new'
  #   end
  # end

  # def post_params
  #   params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  # end
end
