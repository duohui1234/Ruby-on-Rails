class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  has_many :likes
  has_many :liked_users, through: :likes, source: :user


  #검증(model validation)
  validates :title, presence: {message: "제목을 입력해주세요"},
            length: {maximum: 30,
                     too_long: "%{count}자 이내로 입력해주세요"}


  validates :content, presence: {message: "내용을 입력해주세요"}

end
