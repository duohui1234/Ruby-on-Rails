class SessionsController < ApplicationController

  def new
  end

  def create
    #email이 가입되었는지
    #가입되었으면 비밀번호 확인 하기
    #비밀번호 일치하면 로그인
    #비밀번호 다르면 flash+ back
    #가입안되어있으면 flash+ 가입

   user = User.find_by(email: params[:email])
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:notice] = "#{user.username}님 로그인 성공"
        redirect_to '/'
      else
       flash[:alert] = "비밀번호가 다릅니다"
       redirect_to '/login'
     end
   else
     flash[:alert] = "가입이 되지 않은 이메일 입니다"
     redirect_to '/signup'
   end

  end

  def destroy
    session.clear
    flash[:notice] = "로그아웃!"
    redirect_to '/'
  end

end
