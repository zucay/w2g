# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
W2g::Application.initialize!

class ActionDispatch::Http::UploadedFile 
  def initialize(hash)
    @original_filename = hash[:filename].force_encoding("UTF-8")
    @content_type      = hash[:type]
    @headers           = hash[:head]
    @tempfile          = hash[:tempfile]
    raise(ArgumentError, ':tempfile is required') unless @tempfile
  end
end

