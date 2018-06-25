class PostsController < ApplicationController

 #index액션을 제외하고 나머지 모든 액션에 대해서는 먼저 authorize 액션을 먼저 해라
  before_action :authorize, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.reverse
  end

  def new
  end

  def create
    #Post.create(user_id: current_user.id, title: params[:title], content: params[:content])
    #Post.create(post_parmas) 일경우에는 user_id가 자동으로 들어가지 않지만
    #current_user.posts.new(post_params)로 하면 자동으로 유저의 아이디값도 들어간다. new는 꼭 save를 함께 써준다.
    @post = current_user.posts.new(post_params)
    @post.save
    flash[:notice] = "새로운 글이 작성되었습니다"

    redirect_to '/posts'
  end

  def show
    #@post = Post.find(params[:id])
  end

  def edit
    #@post = Post.find(params[:id])
  end

  def update
    #post = Post.find(params[:id])


    # @post.title = params[:title]
    # @post.user_id = current_user.id
    # @post.content = params[:content]
    # @post.save

    @post.update(post_params)

    flash[:notice] = "글이 수정되었습니다"

    redirect_to '/'
  end

  def destroy
    #post = Post.find(params[:id])
    @post.destroy

    flash["alert"] = "글이 삭제되었습니다"

   redirect_to '/'

  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
     #params를 받을 때 title과 content만 허가해준
     params.permit(:title, :content)
 end


end
