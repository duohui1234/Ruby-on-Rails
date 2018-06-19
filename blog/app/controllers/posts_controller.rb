class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create


  post = Post.create(
      title: params[:title],
      body: params[:body]
  )


  flash[:notice] = "글이 작성되었습니다"

  #텍스트 안에 변수를 넣을 때 (textinterpolation) => 반드시 "" 로 써야한다
  redirect_to "/posts/#{post.id}"

  # Post.create(
  #     :title => params[:title],
  #     :body => params[:body]
  # )


  # post = Post.new
  # post.title = params[:title]
  # post.body = params[:body]
  # post.save



  end

  def new

  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy

    flash[:alert] = "글이 삭제되었습니다"

    redirect_to '/'
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.title = params[:title]
    post.body = params[:body]
    post.save

    flash[:notice] = "글이 수정되었습니다"
    #post.update(title: params[:title], body: params[:body])
    #destroy는 삭제된 값을 리턴하지만 , update는 업뎃 성공여부를 true 또는 false 리턴

    redirect_to '/'

  end

end
