ActiveAdmin.register Project do
  form :html =>  { :enctype => "multipart/form-data"} do |f|
    f.inputs "Details" do
      f.input :name
      f.input :client
      f.input :header
      f.input :base_file, :as => :file
      f.input :genre
      f.input :active
      f.input :public
      f.input :created_at
      f.input :description
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
    #column :base_file_file_name
    column :genre
    column :header
    column :active
    column :public
    column :num do |pj|
      pj.spots.size
    end
    default_actions
  end
  show do |pj|
    default_main_content
    panel 'Related Spots(100)' do
      table_for pj.spots.first(100) do
        column :id do |spot|
          link_to(spot.id, admin_spot_path(spot))
        end
        column :name
        column :addr
        column :lat_world
        column :lng_world
      end
    end
  end
end

