class CommentsController < ApplicationController

  def create
    @comment = Post.find(params[:post_id]).comments.new(comment_params)
    @comment.user_id = current_user.id


    if @comment.save
      respond_to do |format|
      format.html {redirect_to :back}
      #만약 action명과 파일명이 다를경우 (create_temp) 일경우는 render 명을 입력해야
      format.js {render 'create_temp'}
      #format.js {}     #따로 렌더 명시안하면 자동으로 create.js.erb 를 렌더한다 (action명과 )

      end
    else
      redirect_to :back
    end
  end



  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy

   respond_to do |format|
     format.html {redirect_to :back}
     format.js { }
   end
  end



  private
  def comment_params
    params.permit(:content)
  end




end
