class LikesController < ApplicationController


def create

    @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
    @post_id = params[:post_id]

    respond_to do |format|
      format.html {redirect_to :back}
      format.js {}
    end

end


   def destroy
     @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id]).destroy
     @post_id = params[:post_id]

     respond_to do |format|
       format.html {redirect_to :back}
       format.js {}
     end



   end

end
