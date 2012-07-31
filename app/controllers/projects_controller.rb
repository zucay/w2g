class ProjectsController < InheritedResources::Base
  layout :select_layout
  def select_layout
    'twitter'
  end
  def index
    redirect_to project_url(Project.order('created_at').last)
  end
end
