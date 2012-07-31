ActiveAdmin.register Header do
  index do
    column :id do |hd|
      link_to(hd.id, admin_header_path(hd))
    end
    column :name

    default_actions
  end
  
end
