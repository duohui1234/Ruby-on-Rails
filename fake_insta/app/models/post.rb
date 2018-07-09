class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  has_many :likes
  has_many :liked_users, through: :likes, source: :user



  mount_uploader :img, ImgUploader
  #스키마 파일에 보면 원래 img는 stirng 인데 이 속성을 자동으로 이미지 업로드로 바까줌


  #검증(model validation)
  validates :title, presence: {message: "제목을 입력해주세요"},
            length: {maximum: 30,
                     too_long: "%{count}자 이내로 입력해주세요"}


  validates :content, presence: {message: "내용을 입력해주세요"}

end
