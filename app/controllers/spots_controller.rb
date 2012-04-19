class SpotsController < InheritedResources::Base
  def new
    @spot = Spot.new
    pj = Project.last
    @spot.project = pj
    
    p @spot
    p pj
    respond_to do |format|
      format.html { render :html => @spot }# new.html.erb
      format.xml  {  render :xml => @feed }
    end
  end
end
