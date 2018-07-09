class TinymceAssetsController < ApplicationController
  def create
  file = params[:file]
  url = upload_image(file)
  render json: {
  image: {
    url: view_context.image_url(image)
  }
}, content_type: "text/html"

  end

 private
 def upload_image(file)
   s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
   obj = s3.bucket(ENV['S3_BUCKET_NAME']).object('/posts/content/'+filename(file)
   obj.upload_file(file.tempfile, {acl: 'public-read'})
   obj.public_url.to_s
 end

 def filename(file)
  "#{Time.now}_#{file.original_filename}"  #원래 파일이름에 시간을 붙여서 파일 네임 생성
 end

end
