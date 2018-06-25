

### [Rails 기본 라우팅](https://guides.rorlab.org/routing.html#%EB%A6%AC%EC%86%8C%EC%8A%A4-%EA%B8%B0%EB%B0%98%EC%9C%BC%EB%A1%9C-%EB%9D%BC%EC%9A%B0%ED%8C%85%ED%95%98%EA%B8%B0-rails%EC%9D%98-%EA%B8%B0%EB%B3%B8)

~~~ruby
#rountes.rb

#index
get 'posts' => 'posts#index'

#CRUD -C
get 'posts/new' => 'posts#new'
post 'posts' => 'posts#create'

#CRUD -R
get 'posts/:id' => 'posts#show'

#CRUD -U
get 'posts/:id/edit' => 'posts#edit'
put 'posts/:id' => 'posts#update'

#CRUD -D
delete 'posts/:id' => 'posts#destroy'
~~~

~~~ruby
resources :posts   #위의 코드를 이 한줄로 대체
~~~

- REST API를 구성하는 기본 원칙
  1. URL은 정보의 자원을 표현한다
  2. 자원에 대한 행위는 HTTP method(verb)로 표현한다. (get, post, put, delete)



### form 에서 post 요청 보내기

~~~html
<!-- new.html.erb-->
<form action="/posts" method="post">
    ..
      <input type ="hidden" name = "authenticity_token"
             value = "<%= form _authenticity_token%>">

    ..
</form>
~~~

~~~ruby
#app/controllers/application_controller.rb
protect_from_forgery with: :exception

#token이 없으면 오류 발생, 토큰 사용이유는 CSRF 공격을 방지하기 위해서임
~~~

###

### put,delete 요청 보내기

~~~html
<!-- new.html.erb-->
<form action="/posts" method="post">
    ..
      <input type = "hidden" name = "_method" value = "put">
      <input type ="hidden" name = "authenticity_token"
             value = "<%= form _authenticity_token%>">

    ..
</form>
~~~

~~~html
<a href = "/posts/<%= p.id %>" data-method="delete" data-confirm="진짜 삭제?">삭제</a>
~~~





### [Database relation(association)](https://guides.rorlab.org/association_basics.html)

- 1:N

  User(1) - Post(N)  관계설정

  유저는 많은 게시글을 가지고 있고, 게시글은 특정 유저에 속한다

- 실제 코드 적용

  ~~~ruby
  #app/model/user.rb
  class User < ActiveRecord
      has_many :posts
  end
  ~~~

  ~~~ruby
  #app/model/post.rb
  class Post < ActiveRecord
      belongs_to :user
  end
  ~~~

  - 데이터베이스 관계 설정 -> `rake db:migrate`

  ~~~ruby
  #db/migrate/20180625_create_posts.rb

  ..
      t.string :title
      t.text :content
      t.integer :user_id #foreign key
  ..
      #t.regerence :user_id
  ~~~

- 실제로 관게를 활용하기

  1. 유저가 가지고 있는 모든 게시글 가져오기

     ~~~ruby
     #1번 유저의 모든 글
     @user_posts = User.find(1).posts

     #그 사람이 쓴 글의 갯수
     User.find(1).posts.count
     ~~~

  2. 특정 게시글에서 작성한 사람 정보 출력

     ~~~ruby
     #1번 글의 유저 작성자 이름
     Post.find(1).user.username
     ~~~



### login

~~~ruby
#app/controllers/sessions_controller.rb
def new #get '/login'
end

def create #post '/login'
    #로그인 성공시
    session[:user_id] = id
end

def destroy
    session.clear
end
~~~



### before filter : 컨트롤러

~~~ruby
#app/controllers/posts_controller
#authorize 메소드를 실행한다, index를 제외하고
before_action :authorize, except: [:index]
~~~

~~~ruby
#app/controllers/application_controller.rb
def authorize
    unless current_user
        flash[:alert] = "로그인 해주세요"
        redirect_to '/'
    end
end
~~~



### Helper method

~~~ruby
#app/controllers/application_controller.rb

#helper_method 명시하면 view에서도 활용 가능한 메소드가 된다
helper_method :current_user
def currenet_user
    @user ||= User.find(params[:id]) if session[:user_id]
    #@user에 값이 있으면, 디비에 쿼리를 날리지 않음, 값이 없을 때만 User.find
end
~~~

- 뷰에서 활용

  ~~~erb
  <% if current_user %>
    <p><%= current_user.username %></p>
    <a href = "/logout"> 로그아웃 </a>
  <% else %>
     <a href = "/login"> 로그인 </a>
     <a href = "/signup"> 회원가입 </a>
  <% end %>
  ~~~
