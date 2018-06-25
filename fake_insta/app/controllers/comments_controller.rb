class CommentsController < ApplicationController
  
  def create
    @comment = Post.find(params[:post_id]).comments.new(comment_params)
    @comment.save
    redirect_to :back
  end

  private
  def comment_params
    params.permit(:content)
  end
end
