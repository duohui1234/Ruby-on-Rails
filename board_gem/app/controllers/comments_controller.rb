class CommentsController < ApplicationController

  #before_action :set_post, only: [:show, :destroy, :edit, :update]


  def create
    @comment =  Post.find(params[:post_id]).comments.new(comment_params)
    @comment.save

    redirect_back fallback_location: root_path
  end


  private
  def comment_params
    params.permit(:content)
  end

end
