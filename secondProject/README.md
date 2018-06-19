`rails g model post` : post 객체 만듬

`migrate` 폴더 내에 `t.string :title ` 입력 => 테이블 틀만 만듬

`rake db:migrate` <->`rake db:drop`



`$rails console`

`Post.create(title: "test", body: "test")`

`Post.all`
