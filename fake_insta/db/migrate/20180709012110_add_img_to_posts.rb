class AddImgToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :img, :string
    #remove_column :테이블명, :컬럼, :datatype
    #change_column :posts, :title, :text
  end
end
