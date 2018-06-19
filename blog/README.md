

#### Setting

`rails g model post` : post 객체 만듬

`migrate` 폴더 내에 `t.string :title ` 입력 => 테이블 틀만 만듬

`rake db:migrate` <->`rake db:drop`



`$rails console`

`Post.create(title: "test", body: "test")`

`Post.all`



#### Rails CRUD

-

- ORM(Object Relational Mapper)

  - rails에서는 [ActiveRecord](https://guides.rorlab.org/active_record_basics.html)를 활용한다

- Controller 생성

  ~~~
  $rails g controller post index new create show edit update destroy
  ~~~

- Model 생성

  ~~~
  $rails generate model post
  ~~~

  - `app/model/post.rb`
  - `db/migrate/21080619_create_posts.rb`

- `migration` 파일 변경

  ~~~ruby
  #db/migrate/21080619_create_posts.rb

  class CreatePosts < ActiveRecord::Migration[5.2]
    def change
      create_table :posts do |t|

        t.string 'title'
        t.text 'body'
        t.timestamps

      end
    end
  end
  ~~~

  ~~~
  $rake db:migrate   
  ~~~

  ~~~
  $rake db:drop   //반드시 db/schema.rb에 반영이 되었는지 확인
  ~~~

- CRUD

  - Create : `new` , `create`

  - Read : `show`

  - Update : `edit`  , `update`

  - Destroy : `destroy`



- `rails console`에서

- Create

  ~~~
  irb(main):001:0> Post.create(title: "제목", body: "내용")
  ~~~

- Read

- ~~~
  irb(main):001:0> Post.find(id)
  ~~~

- Update

  ~~~
  irb(main):001:0> post = Post.find(id)
  irb(main):001:0> post.update(title: "변경", body: "변경")
  ~~~

- Destroy

  ~~~
  irb(main):001:0> Post.find(id).destroy
  ~~~



#### [Rails flash message](https://guides.rorlab.org/action_controller_overview.html#flash)

~~~ruby
def destroy
    flash[:alert] = "삭제되었습니다"
end
~~~

~~~erb
<%= flash[:alert] %>
~~~



#### [Rails partial](https://guides.rorlab.org/layouts_and_rendering.html#%ED%8C%8C%EC%85%9C-partial-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0)

`app/views/layout/_flash.html.erb`

~~~erb
<%= render 'layouts/flash' %>
~~~
