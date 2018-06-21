class PostsController < ApplicationController

 #index액션을 제외하고 나머지 모든 액션에 대해서는 먼저 authorize 액션을 먼저 해라
  before_action :authorize, except: [:index]

  def index
    @posts = Post.all.reverse
  end

  def new
  end

  def create
    Post.create(user_id: current_user.id, title: params[:title], content: params[:content])

    flash[:notice] = "새로운 글이 작성되었습니다"

    redirect_to '/posts'
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.title = params[:title]
    post.user_id = current_user.id
    post.content = params[:content]
    post.save

    flash[:notice] = "글이 수정되었습니다"

    redirect_to '/'
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy

    flash["alert"] = "글이 삭제되었습니다"

   redirect_to '/'

  end
end
