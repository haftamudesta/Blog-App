class CommentsController < ApplicationController
  def create
    @comment = @post.comments.create(comments_params)
    @comment.user = current_user
    flash[:notice] = if @comment.save
                       'Comment has been created'
                     else
                       'Comment has not been created'
                     end
    redirect_to post_path(@post)
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comments_params
    params.require(:comment).permit(:text)
  end
end
