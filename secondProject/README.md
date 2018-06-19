### Rails CRUD



`$ rails g controller index`

` $ rails g model post`

```ruby
#db\migrate\~~~_posts.db
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title #추가 부분
      t.text :body #추가 부분
      t.timestamps
    end
  end
end
```

반드시 위 추가 이후 migrate를 해야 schema가 최신화 됨!! 반드시!!

`rake db:migrate`

```ruby
#db\migrate\schema.rb
ActiveRecord::Schema.define(version: 2018_06_19_011308) do

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
```



DB 삭제(window환경에서는 drop error 발생함)

- db/migrate/developmetn.sqlite3 지우고 ~~~_posts.rb 수정 후 다시 `rake db:migrate`

` rake db:drop`



##### Cosole로 DB관리

`rails console`

```cmd
##In rails console

##Post model 확인
> Post.all

#irb(main):001:0> Post.all
#  Post Load (13.5ms)  SELECT  "posts".* FROM "posts" LIMIT ?  
# [["LIMIT", 11]]
#=> #<ActiveRecord::Relation []>

## insert test data
> Post.create(title:"test",body:"test")

#irb(main):002:0> Post.create(title:"test",body:"test")
#   (0.3ms)  begin transaction
#  Post Create (22.9ms)  INSERT INTO "posts" ("title", "body", #"created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "test"],
#["body", "test"], ["created_at", "2018-06-19 01:39:44.133587"],
#["updated_at", "2018-06-19 01:39:44.133587"]]
#   (34.4ms)  commit transaction
#=> #<Post id: 1, title: "test", body: "test", created_at: "2018-06-19 #01:39:44", updated_at: "2018-06-19 01:39:44">


```



#### DB GUI에서 관리하기

- Gemfile

```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rails_db'  ### 이gem 추가
end

```

항상 gem 추가 후

`bundle install`

`http://localhost:3000/rails/db`



##### Data visualization

```ruby
#routes.rb
root 'post#index'
get 'post/index' => 'post#index'
```

```erb
<!--Index.html.erb-->

<h1>Post#index</h1>

<% @posts.each do |post|%>
    <p><%= post.id%></p>
    <p><%= post.title%></p>
    <p><%= post.body%></p>
    <p><%= post.created_at%></p>
<%end%>
```

```ruby
#post_controller.rb
def index
    @posts = Post.all
end
