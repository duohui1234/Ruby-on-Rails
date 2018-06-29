class CommentsController < ApplicationController

  def create
    @comment = Post.find(params[:post_id]).comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
      format.html {redirect_to :back}
      format.js {}   #따로 렌더 명시안하면 자동으로 create.js.erb 를 렌더한다 (action명과 동일)
      end
    else
      redirect_to :back
    end
  end


  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to :back
  end

  private
  def comment_params
    params.permit(:content)
  end




end
