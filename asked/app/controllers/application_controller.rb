class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  #helper_method 어느 뷰에서든 사용할 수 있도록 한다

  helper_method :current_user
  def current_user
    #session에 저장되어있는 경우 @User를 찾아서 저장ㅎ나다.
    #||= 으로 저장하는 이유는 @user가 비어있는 경우에만 활용하기 위해서 이다
    #@user가 비어있을 때만 User.find해서 값을 넣어준다
    @user ||=  User.find(session[:user_id]) if session[:user_id]
  end

  

end
