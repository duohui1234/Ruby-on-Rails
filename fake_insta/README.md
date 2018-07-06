#### Post(1)

- posts 컨트롤러 `rails g controller posts index new create show edit update destroy`
- posts 모델 `rails g model post title:string content:text`

#### Comment(N)

- comments 컨트롤러
  - CRUD - C
- Commnets 모델
  - `rails g model comment content:string`
  - post _ id 저장


#### Devise

1. `devise` gem 설치

   ~~~ruby
   #Gemfile
   gem 'devise'
   ~~~

   ~~~~
   $bundle install
   ~~~~

2. devise 설치

   ~~~
   $rails generate devise:install
   ~~~


- `config/initialize/devise.rb` 만들어짐

3. user 모델 만들기

   ~~~
   $rails generate devise user
   ~~~


- `db/migrate/20180625_devise_create_users.rb`
- `model/user.rb`
- `config.routes.rb`: devise_for :users

4. migration

   ~~~
   $rake db:migrate
   ~~~

5. Routes 확인

   | new_user_session_path         | GET    | /users/sign_in(.:format)       | devise/sessions#new          |
   | ----------------------------- | ------ | ------------------------------ | ---------------------------- |
   | user_session_path             | POST   | /users/sign_in(.:format)       | devise/sessions#create       |
   | destroy_user_session_path     | DELETE | /users/sign_out(.:format)      | devise/sessions#destroy      |
   | user_password_path            | POST   | /users/password(.:format)      | devise/passwords#create      |
   | new_user_password_path        | GET    | /users/password/new(.:format)  | devise/passwords#new         |
   | edit_user_password_path       | GET    | /users/password/edit(.:format) | devise/passwords#edit        |
   |                               | PATCH  | /users/password(.:format)      | devise/passwords#update      |
   |                               | PUT    | /users/password(.:format)      | devise/passwords#update      |
   | cancel_user_registration_path | GET    | /users/cancel(.:format)        | devise/registrations#cancel  |
   | user_registration_path        | POST   | /users(.:format)               | devise/registrations#create  |
   | new_user_registration_path    | GET    | /users/sign_up(.:format)       | devise/registrations#new     |
   | edit_user_registration_path   | GET    | /users/edit(.:format)          | devise/registrations#edit    |
   |                               | PATCH  | /users(.:format)               | devise/registrations#update  |
   |                               | PUT    | /users(.:format)               | devise/registrations#update  |
   |                               | DELETE | /users(.:format)               | devise/registrations#destroy |

- 회원가입 :  get 'users/sign_up'
- 로그인 : get 'user/sign_in'
- 로그아웃 : delete 'users/sign_out'

6. helper method

- `user_sign_in?`

  : 유저가 로그인 했는지 안했는지 true/false로 리턴

- `current_user`

  : 로그인되어있는 user 오브젝트를 가지고 있음

- `before_action :authenticate_user!`

  :로그인 되어있는 유저 검증(필터)

7. View 파일 수정하기 (두가지 방법)

   ~~~ruby
   #1번
   $ rails generate devise:views users

   #config/initializers/devise.rb
   config.scoped_views = true
   ~~~

   ~~~ruby
   #2번
   $ rails generate devise:views
   ~~~
   - 모든 initializers 폴더 안에 있는 설정은 서버를 껐다가 켜야 반영

8. [custom column 추가하기](https://github.com/plataformatec/devise#strong-parameters)

   1. Migration 파일에 원하는 column 추가

   2. `app/views/devise/registrations/new.html.erb` input 추가

   3. `app/controllers/application_controlle.rb`

      ~~~ruby
      class ApplicationController < ActionController::Base
        # Prevent CSRF attacks by raising an exception.
        # For APIs, you may want to use :null_session instead.
        protect_from_forgery with: :exception
        before_action :configure_permitted_parameters, if: :devise_controller?

      protected

      def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      end

      end
      ~~~




### Faker

~~~ruby
Post.find(1)
Post.first(3)
Post.last(3)
Post.order(:title) #title column 기준 정렬
Post.order(title: :desc) #z-a
Post.order(title: :asc) #a-z
Post.where("title=?","Golduck") #title column에서 datark Golduck인거 찾아줌
Post.where("title like ?", "%duck%") #title column에서 duck이 들어간 것을 찾아줌
Post.where.not("조건")
User.where("age=? AND gender =?",25,"mail")
~~~

~~~ruby
pry(main)> User.all
pry(main)> app.post('/users/sign_in',email: 'duohui12@gmail.com', password: '1111')
pry(main)> app.session[:session_id]
pry(main)> app.controller.params
pry(main)> app.flash
~~~



### Import csv file

~~~ruby
#db폴더 내에 mydata.csv파일 넣어둠

require 'csv'
CSV.foreach(Rails.root.join('db','mydata.csv'), {headers: true, encoding: "UTF-8"}) do |row|
  Post.create! row.to_hash
end
~~~



### [Form_tag, From_for](https://guides.rorlab.org/form_helpers.html)

~~~html
<form action="/posts" method="post">
  <input type="text" name="title" /> <br />
  <textarea name="content"></textarea> <br />
  <input type="hidden" name="authenticity_token" value="<%=form_authenticity_token%>">
  <input type="submit" />
</form>
~~~

~~~ruby
#post방식일 결우 자동으로 토큰 생성
<%= form_tag('/posts', method: 'post') do %>
  <%= text_field_tag :title %><br />
  <%= text_area_tag :content %><br />
  <%= submit_tag "작성하기" %>
<%= end%>
~~~

~~~ruby
<%= form_for @post do |f| %>
  <%= f.text_field :title %>
  <%= f.text_area :content%>
  <%= f.submit %>
<% end %>
~~~

- `form_for의` 주요 특징
  - 특정한 모델의 객체를(Post)를 조작하기 위해 사용
  - 별도의 url(action="/"),method(get,post,put)을 명시하지 않아도 됨.
  - Controller의 해당 액션(new, edit)에서 반드시 @post에 Post 오브젝트가 담겨야함
    - `new`: `@post = Post.new ` new에서는 비어있기 때문에 자동으로 create로인식
    - `edit` : `@post = Post.find(id)` edit에는 값이 들어있기 때문에 update로
  - 각 input field의 symbol은 반드시 @post의 column명이랑 일치해야함

### Link_to:url helper

~~~ruby
<%= link_to '글보기', @post %>
<%= link_to '글보기', post_path %>
<%= link_to '새글쓰기', new_post_path %>
<%= link_to '글 수정', edit_post_path %>
<%= link_to '모근 글보기', posts_path %>
<%= link_to '글 삭제', post_path, method: :delete, data: {confirm: "지울래?"}%>
~~~



### Gem: [simple form](https://github.com/plataformatec/simple_form)

- Gemfile 설정

~~~ruby
gem 'simple_form'
~~~

~~~
$bundle install
~~~

~~~
$rails generate simple_form:install --bootstrap
~~~

- Bootstrap에 적용

  - CDN을 `application.html.erb`

- [from helper](https://apidock.com/rails/ActionView/Helpers/UrlHelper/link_to) 적용

  ~~~ruby
  <%= simple_form_for @post do |f| %>
  <%= f.input :title %>
  <%= f.input :content %>
  <%= f.button :submit %>
  <%end%>
  ~~~




### Model validation

```ruby
#app/models/posts.rb

class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user


  #검증(model validation)
  validates :title, presence: {message: "제목을 입력해주세요"},
            length: {maximum: 30,
                     too_long: "%{count}자 이내로 입력해주세요"}


  validates :content, presence: {message: "내용을 입력해주세요"}

end
```

```ruby
def create
    @post = Post.new(post_params)
    respond_to do |format|
        if @post.save   #post가 정상적으로 저장되었을 경우에는
            format.html {redirect_to '/', notice: "글 작성완료" } #notice는 flash[:notice]에 값을 담기 위해
        else     
            format.html {render :new}
            format.json {render json: @post.errors}
        end
    end
end
```

```erb
<!-- app/views/posts/_form.html.erb -->
..
 <%= f.error_notification %>
..
```

#### custom helper

```ruby
#app/helpers/application_helper.rb
def flash_message(type)
    case type
    when "alert" then  "alert alert-warnig"
    when "notice" then  "alert alert-primary"
    end
end
```

```erb
<!-- app/views/layout/application.html.erb -->

<% flash.each do |key,value| %>
   <div class = "<%= flash_message(key) %>" role="alert">
     <%= value %>
   </div>
<% end %>
```



### [kaminari](https://github.com/kaminari/kaminari) - pagination

~~~ruby
#Gemfile
gem 'kaminari'
~~~

~~~
$bundle install
~~~

~~~ruby
# app/controllers/posts_controller.rb

def index
    #@posts = Post.all.page(params[:page]).per(5)
     @posts = Post.order(created_at: :desc).page(params[:page]).per(3)  #page쓸때는 reverse 안먹음
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
end
~~~

~~~ruby
#index.html.erb
...
<%= paginate @posts %>
<br/>
~~~

#### [bootstrap theme](https://github.com/amatsuda/kaminari_themes) - 테마 설정

~~~
$rails g kaminari:views bootstrap4
~~~



### [cancancan](https://github.com/CanCanCommunity/cancancan) - 권한설정

- 로그인한 사용자가 작성한 글만 삭제, 수정할 수 있도록 도와줌

~~~
$ gem 'cancancan', '~> 2.0'
~~~

~~~
$ rails g cancan:ability     // app/models/ability.rb 생성
~~~

#### [Defining Abilities](https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities)

~~~ruby
# app/models/ability.rb

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    return unless user.present?
    can :manage, Post, user_id: user.id
    can :create, Comment
  end

end
~~~

~~~ruby
#controller ability 확인
#app/controllers/posts_controller.rb

#restful resources를 사용하는 경우에만 가능, 아닌 경우에는 독립적으로 액션별로 설정해줘야 함
class PostsController < ApplicationController
  load_and_authorize_resource
    ...
end
~~~

~~~ruby
#view에서 ability 확인

<% if can? :edit, @post %>
   <%= link_to '수정하기', edit_post_path(@post) %>
<%end%>

<% if can? :destroy, @post %>
    <%= link_to '삭제하기',@post, method: :delete, data: {confirm: '지울꺼야?'}%>
<%end%>
~~~

####  Handle Unauthorized Access

- 로그인한 사용자가 작성한 글이 아닐경우 수정이나 삭제 누르면 루트 페이지로 보내고 메세지 출력하도록 함

~~~ruby
#app/controllers/application_controller.erb

class ApplicationController < ActionController::Base

    ...

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_to main_app.root_url, notice: exception.message }
        format.js   { head :forbidden, content_type: 'text/html' }
      end
    end

    ...

end    
~~~


## Rails ajax 구현



#### 글 생성시 ajax

- data-remote = true (html 태그 기준)

  ~~~ruby
  <h3>댓글 작성하기</h3>
  <form action="/posts/<%= @post.id%>/comments" method="post" data-remote=true>
    <input type="text" name="content" />
    <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">
    <input type="submit" />
  </form>
  <hr />
  ~~~

- CommentsController => create action

  ~~~ruby
    def create
      @comment = Post.find(params[:post_id]).comments.new(comment_params)
      @comment.user_id = current_user.id


      if @comment.save
        respond_to do |format|
        format.html {redirect_to :back}
        #만약 action명과 파일명이 다를경우 (create_temp) 일경우는 render 명을 입력해야
        #format.js {render 'create_temp'}

        #따로 렌더 명시안하면 자동으로 create.js.erb 를 렌더한다 (action명과 )
        format.js {}    
        end
      else
        redirect_to :back
      end
    end
  ~~~

- create.js.erb 작성 (escape_javascript의 약어는 j)

  ~~~ruby
  $("div#comments").append("<p><%= escape_javascript(@comment.content) %><%= escape_javascript(link_to '삭제하기', destroy_comment_path(@comment.id), method: :delete, remote: true, class: 'delete_comment') %></p><hr/>");
  ~~~

- show.html.erb 파일에 ajax 결과에 따른 event handler 작성

  ~~~javascript
  <script>
    $('form').on("ajax:success", function(){
       $('input[name="content"]').val("");
    });
  </script>
  ~~~



#### 글 삭제시 ajax 구현

- remote: true (rails 코드 기준)

  ~~~ruby
  <div id = "comments">
  <% @comments.each do |comment| %>
    <p>
       <%= comment.content %>
       <%= link_to '삭제하기', destroy_comment_path(comment.id), method: :delete, remote: true, class: "delete_comment" %>
    </p>
    <hr />
  <% end %>
  </div>
  ~~~

- CommentsController => destroy action

  ~~~ruby
    def destroy
      @comment = Comment.find(params[:comment_id])
      @comment.destroy

     respond_to do |format|
       format.html {redirect_to :back}
       format.js { }
     end
    end
  ~~~

- destroy.js.erb작성

  ~~~javascript
  var parent = $('a[href="/comments/<%= params[:comment_id] %>"]').parent();  //p태그 삭제
  var hr = parent.next();   //hr태그 삭제
  parent.remove();
  hr.remove();
  ~~~





## jQuery로 ajax 구현

- 글 생성시 ajax 구현

  ~~~javascript
  <script>   
  $('input[type="submit"]').on('click',function(e){
        e.preventDefault();
        alert('start_submit');
        $.ajax({
          url: $('form').attr('action'),
          type: 'POST',
          data: {content: $('input[name="content"]').val(),
                 authenticity_token:$('[name="csrf-token"]').attr('content')
                },
          dataType: 'script',
          success: function(){
            alert('success')
            $('input[name="content"]').val("");
          },
          error: function(){
            alert('fail')
          }
        });
      });
  </script>
  ~~~

- 글 삭제시 ajax 구현

  ~~~javascript
  <script>    
  $('.delete_comment').on("click",function(e){
         e.preventDefault();
         alert('start_delete');
         $.ajax({
           url: this.href,
           type: 'DELETE',
           data: {authenticity_token:$('[name="csrf-token"]').attr('content')},
           dataType: 'script',
           success: function(){
              alert('delete_complete');
           },
           error: function(){
             alert('delete_error');
           }
         });
      });
  </script>
  ~~~

- 이후 rails의 ajax 구현 순서와 동일


## 게시판 좋아요 기능

~~~console
$ rails g model like
~~~

~~~ruby
class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :post   #실제 디비에는 post_id로 들어감
      t.references :user
      t.timestamps null: false
    end
  end
end
~~~

~~~console
$ rake db:migrate
~~~

~~~ruby
#post.rb
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
~~~

~~~ruby
#user.rb
  has_many :likes
  has_many :lliked_posts, through: :likes, source: :post
~~~

~~~ruby
#user.rb
  belongs_to :user
  belongs_to :post
~~~

~~~ruby
#post/index.html.erb

 <% if current_user.liked_posts.include? post %>

    <%= link_to  "posts/#{post.id}/like", data: {id: post.id}, remote: true, method: :delete do%>
    <i class="fas fa-heart"></i>
 <% end %>
 <%else%>
    <%= link_to  "posts/#{post.id}/like", data: {id: post.id}, remote: true, method: :put  do%>
    <i class="far fa-heart"></i>
 <% end %>

 <%end%>
~~~

~~~ruby
#routes.rb

  put '/posts/:post_id/like' => 'likes#create'
  delete '/posts/:post_id/like' => 'likes#destroy'
~~~

~~~ruby
#likes_controller
class LikesController < ApplicationController


def create
    @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
    @post_id = params[:post_id]

    respond_to do |format|
      format.html {redirect_to :back}
      format.js {}
    end
end


def destroy
     @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id]).destroy
     @post_id = params[:post_id]

     respond_to do |format|
       format.html {redirect_to :back}
       format.js {}
     end
   end


end
~~~

~~~ruby
#views/ikes/create.js.erb
var like_btn = $('a[data-id= <%= @post_id %>]');

like_btn.next().text(<%= Post.find(@post_id).liked_users.count %>)
like_btn.replaceWith(`
  <%= link_to  "posts/#{@post_id}/like", data: {id: @post_id}, remote: true, method: :delete do %>
  <i class="fas fa-heart"></i>
  =<% end %>`)
~~~

~~~ruby
var like_btn = $('a[data-id= <%= @post_id %>]');

like_btn.next().text(<%= Post.find(@post_id).liked_users.count %>)
like_btn.replaceWith(`
  <%= link_to  "posts/#{@post_id}/like", data: {id: @post_id}, remote: true, method: :put do%>
  <i class="far fa-heart"></i>
  <% end %>
  `)
~~~



- `rails c` 에서

~~~console
Like.where(post_id: 39)
Post.find(39).likes
Post.find(39).liked_users
Post.find_by(user_id: 1, post_id: 22)
current_users.liked_posts.include? post.find(22)
~~~
