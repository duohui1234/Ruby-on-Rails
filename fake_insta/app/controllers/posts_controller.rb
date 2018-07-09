class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(3)
    respond_to do |format|
      format.html  #render 페이지를 따로 작성하지 않을 경우 default로 index.html을 렌더한다 (action명과 동일)
      format.json { render json: @posts }
    end
  end


  def new
    @post = Post.new
  end


  def create
      @post = current_user.posts.new(post_params)
      respond_to do |format|
      if @post.save #저장이 되었을 경우 true 리턴
        #flash[:notice] = "글 작성이 완료되었습니다"
        #redirect_to "/"
        format.html{redirect_to '/', notice: '글작성완료'}
      else #저장실패
        #flash[:alert] = "글 작성이 실패했습니다"
        #redirect_to new_post_path
        format.html {render :new}
        format.json {render json: @post.errors}
     end
    end
  end



  def show
    @comments = @post.comments
  end

  def edit

    #현재 로그인한 사용자가 쓴글만 삭제 수정할 수 있도록 하는 로
    # if current_user.id == @post.user.id
    #
    # else
    #   redirect_to '/'
    # end
  end

  def update

    respond_to do |format|
      if  @post.update(post_params)
          format.html {redirect_to @post, notice: '글 수정완료'}
      else
          format.html {render :edit}
          format.json {render json: @post.error}
      end
    end
  end


  def destroy
    @post.destroy
    redirect_to "/"
  end



  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :img)
  end





end
