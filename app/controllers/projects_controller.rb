class ProjectsController < InheritedResources::Base
  layout :select_layout
  def select_layout
    'twitter'
  end
  def index
    redirect_to project_url(Project.public.order('created_at').last)
  end
  def show
    begin
      if(!resource.public)
        redirect_to project_url(Project.public.order('created_at').last)
        return
      end
      super
    rescue
      #when the resource is not found
      redirect_to project_url(Project.public.order('created_at').last)
    end
  end
end
