class CommentsController < ApplicationController
  def new
    @comment = Comment.includes([:author]).new
  end

  def create
    @comment = Comment.includes([:author],[:rich_text_text]).new(comment_params)

    @comment.post = Post.includes([:author],[:rich_text_text]).find(params[:post_id])
    @comment.includes(:author).author = current_user

    if @comment.save

      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
    else
      render :new, alert: 'An error has occurred while creating the comment'

    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :text)
  end
end
