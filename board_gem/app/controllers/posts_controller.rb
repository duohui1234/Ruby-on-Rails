class PostsController < ApplicationController

   before_action :set_post, only: [:show, :destroy, :edit, :update]

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    post = Post.new(post_params)
    post.save
  end

  def show
    @post
  end

  def edit
    @post
  end

  def update
    @post.update(post_params)
    redirect_to '/'
  end

  def destroy
     @post.destroy
     redirect_to '/'

  end



  private

  def set_post
    @post = Post.find(params[:id])
  end


  def post_params
    params.permit(:title, :content)
  end
end
