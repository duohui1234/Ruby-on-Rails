class UsersController < ApplicationController

  def create

    # #email 검증
    # if User.find_by(email: params[:email]).nil?
    # #비밀번호 확인
    #   if params[:password] == params[:password_confirmation]
    #     User.create(username: params[:username], email: params[:email], password: params[:password])
    #     flash[:notice] = "회원가입을 축하합니다"
    #     redirect_to '/'
    #   else
    #     flash[:alert] = "비밀번호가 일치하지 않습니다"
    #     redirect_to '/signup'
    #   end
    #
    # else
    #   flash[:alert] = "이미 가입된 이메일 입니다"
    #   redirect_to '/signup'
    # end


    unless User.find_by(email: params[:email])
      @user = User.new(username: params[:username], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

      #가입이 되면 true 리턴하면서 저장, 비밀번호가 다르면 false 리턴하면서 저장 안됨
      if @user.save
        flash[:notice] = "가입을 축하합니다"
        redirect_to '/login'
      else
        flash[:alert] = "비밀번호가 다릅니다"
        #redirect_to '/signup'
        redirect_back fallback_location: root_path
      end

    else
        flash[:alert] = "이미 등록된 이메일입니다"
        redirect_to '/signup'
    end

  end



  def index
  end

  def new
  end


  def posts
    @posts = current_user.posts
  end


end
