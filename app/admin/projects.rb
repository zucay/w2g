ActiveAdmin.register Project do
  form :html =>  { :enctype => "multipart/form-data"} do |f|
    f.inputs "Details" do
      f.input :name
      f.input :client
      f.input :base_file, :as => :file
    end
    f.buttons
  end

  show do |pj|
    default_main_content
    section 'Related Spots(100)' do
      table_for pj.spots.first(50) do
        column :id
        column :name
        column :addr
        column :lat_world
        column :lng_world
      end
    end
  end
end

