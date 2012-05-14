# set credentials from ENV hash
# ENV vars on heroku: 
# $ heroku config:add S3_KEY=XYZXYZ S3_SECRET=XYZXYZ
#S3_CREDENTIALS = {  :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => "sharedearth-production"}
# get credentials from YML file

envvars = ['w2g_access_key_id', 'w2g_secret_access_key', 'w2g_bucket',
           'w2g_s3_host_name', 'w2g_yappid'
          ]
not_found_envvars = []
envvars.each do |var|
  if(ENV[var])
    p "ENV[var] : #{ENV[var]}"
  else
    not_found_envvars << var
  end
end
if(not_found_envvars.size > 1)
  str = not_found_envvars.join(',')
  raise "ENV(#{str}) not found.to set envvar in heroku, use heroku config:add foo=var"
end

W2g::Application.config.S3_CREDENTIALS = { }
cre = W2g::Application.config.S3_CREDENTIALS
cre[:access_key_id] = ENV['w2g_access_key_id']
cre[:secret_access_key] = ENV['w2g_secret_access_key']
cre[:bucket] = ENV['w2g_bucket']
cre[:s3_host_name] = ENV['w2g_s3_host_name']
cre[:s3_host_name] ||= 's3-ap-northeast-1.amazonaws.com'


W2g::Application.config.yappid = ENV['w2g_yappid']
