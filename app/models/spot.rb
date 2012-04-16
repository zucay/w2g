class Spot < ActiveRecord::Base
  has_attached_file :pic1, {
    :storage => :s3,
    :s3_credentials => W2g::Application.config.S3_CREDENTIALS,
    :path => ":attachment/:id/:style.:extension"
  }
end
