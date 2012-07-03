ActiveAdmin.register Project do
  form :html =>  { :enctype => "multipart/form-data"} do |f|
    f.inputs "Details" do
      f.input :name
      f.input :client
      f.input :base_file, :as => :file
    end
    f.buttons
  end
end
