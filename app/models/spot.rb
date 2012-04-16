class Spot < ActiveRecord::Base

  has_attached_file :pic1, {
    :storage => :s3,
    :s3_credentials => Rails.root.join("config/s3.yml"),
    :path => ":attachment/:id/:style.:extension"
  }

end
