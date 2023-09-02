class CommentsController < ApplicationController
    def new
      @comment = Comment.new
    end
  
    def create
      @comment = Comment.new(comment_params)
      
      @comment.post = Post.find(params[:post_id])
      @comment.author = current_user
      
        if @comment.save
  
          redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
        else
          render :new, alert: 'An error has occurred while creating the comment'
      
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:title,:text)
    end
end
  