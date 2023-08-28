class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    flash[:notice] = 'Like has not been created' unless @like.save
    redirect_to @like.post
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    post = @like.post
    @like.destroy
    redirect_to post
  end

  private

  def like_params
    params.require(:likes).permit(:post_id)
  end
end
