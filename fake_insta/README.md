#### Post(1)

- posts 컨트롤러 `rails g controller posts index new create show edit update destroy`
- posts 모델 `rails g model post title:string content:text`

#### Comment(N)

- comments 컨트롤러
  - CRUD - C
- Commnets 모델
  - `rails g model comment content:string`
  - post _ id 저장
  -

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