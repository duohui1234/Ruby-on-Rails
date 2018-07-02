class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def map
    #code
  end


  def map_data
    max = JSON.parse(params[:max])  #json_string => hash
    min = JSON.parse(params[:min])
    indices = JSON.parse(params[:indices]) #네이버 맵에 이미 로딩되어있는 학교들의 id값이 들어있다

    school = School.where("(lat BETWEEN ? and ?) and (lng BETWEEN ? and ?)",min["_lat"],max["_lat"],min["_lng"],max["_lng"])
    school_id = school.map { |x| x.id }
    school_id -= indices #루비는 배열의 - 를 지원, indices 안에 없는 내용만 남긴다. 이미 로딩되어있는 학교제외하고 없는 학교만 추가로 보내기위해

    if school_id.length == 0
      school = []
    else
      #school_id에 존재하는 학교만 @school에 저장
      school = school.select {|x| school_id.include? x.id}
    end

    respond_to do |format|
      format.json { render json: [school, school_id]}  #@school 데이터를 json 형식으로 바꿔서 render
    end
  end


  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @post = Post.new
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new

  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to '/posts', notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
        format.js {}

      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
