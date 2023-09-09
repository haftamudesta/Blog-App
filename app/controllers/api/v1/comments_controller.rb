class Api::V1::CommentsController < ApplicationController
  def new; end

  def index
    comments = Post.find(params[:post_id]).comments
    render json: comments, status: 200
  end

  def create
    comment = Comment.new(post_params)
    if comment.save
      render json: comment, status: 200
    else
      render json: {
        error: 'error creating...'
      }

    end
  end

  def destroy
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy
    post.comments_counter -= 1
    post.save
    redirect_to user_post_path(user_id: user.id, id: post.id), notice: 'Post deleted successfully.'
  end

  private

  def post_params
    params.require(:comment).permit(:text)
  end
end
