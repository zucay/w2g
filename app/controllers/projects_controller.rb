class ProjectsController < InheritedResources::Base
  layout :select_layout
  def select_layout
    'twitter'
  end
  def index
    redirect_to project_url(Project.public.order('created_at').last)
    super
  end
  def show
    begin
      if(!resource.public)
        redirect_to project_url(Project.public.order('created_at').last)
        return
      end
      super
    rescue
      redirect_to project_url(Project.public.order('created_at').last)
    end
  end
end
