# set credentials from ENV hash
# ENV vars on heroku: 
# $ heroku config:add S3_KEY=XYZXYZ S3_SECRET=XYZXYZ
#S3_CREDENTIALS = {  :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => "sharedearth-production"}
# get credentials from YML file
W2g::Application.config.S3_CREDENTIALS = Rails.root.join("config/s3.yml")

