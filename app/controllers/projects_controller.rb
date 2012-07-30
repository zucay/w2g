class ProjectsController < InheritedResources::Base
  layout :select_layout
  def select_layout
    'twitter'
  end
end
