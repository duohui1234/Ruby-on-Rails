class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :post   #실제 디비에는 post_id로 들어감
      t.references :user
      t.timestamps null: false
    end
  end
end
