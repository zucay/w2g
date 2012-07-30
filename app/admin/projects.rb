ActiveAdmin.register Project do
  form :html =>  { :enctype => "multipart/form-data"} do |f|
    f.inputs "Details" do
      f.input :name
      f.input :client
      f.input :base_file, :as => :file
      f.input :genre
      f.input :active
      f.input :public
      f.input :created_at
    end
    f.buttons
  end
  index do
    column :id do |pj|
      link_to(pj.id, admin_project_path(pj))
    end
    column :name
    column :client
    column :created_at
    column :base_file_file_name
    column :genre
    column :active
    column :public
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

