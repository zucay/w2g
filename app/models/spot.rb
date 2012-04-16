class Spot < ActiveRecord::Base

  has_attached_file :pic1, {
    :storage => :s3,
    :s3_credentials => Rails.root.join("config/s3.yml"),
    :path => ":attachment/:id/:style.:extension"
  }
=begin
  :storage => :s3,
  :s3_credentials => {
    :access_key_id => 'AKIAI3P3AAIAS5KXLM7Q', 
    :secret_access_key => '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'
  },
  :bucket => 'w2g-development',
  :s3_host_name => 's3-ap-northeast-1.amazonaws.com',
  #:path => ":attachment/:id/:style/:filename"
  :path => ":attachment/:id/:style.:extension"
  }
=end
#  :s3_credentials => Rails.root.join("config/s3_test.yml"),
#  :bucket => 'w2g-development',
#  :s3_host_name => 's3-ap-northeast-1.amazonaws.com'

=begin
  has_attached_file :pic1,
   :storage => :s3,
   :s3_credentials => W2g::Application.config.S3_CREDENTIALS,
#   :path => "people/photo/:id/:style.:extension",
#   :url  => ":s3_domain_url",
   :s3_protocol => 'http',
#   :bucket => "jdcdevelop",
   :styles => {:medium => "300x300>", :thumb => "100x100>" }


  has_attached_file :pic1, :styles => {  :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :pic2, :styles => {  :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :pic3, :styles => {  :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :pic4, :styles => {  :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :pic5, :styles => {  :medium => "300x300>", :thumb => "100x100>" }
=end
end
