class PostsController < ApplicationController
  def index
    @posts = Post.all.reverse
    end

  def new
  end

  def create
    Post.create(username: params[:username], title: params[:title], content: params[:content])
    redirect_to '/posts/index'
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
    post.username = params[:username]
    post.content = params[:content]
    post.save

    redirect_to '/'
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy

   redirect_to '/'

  end
end
