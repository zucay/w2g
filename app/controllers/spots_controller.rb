# -*- coding: utf-8 -*-
class SpotsController < InheritedResources::Base
  def index
    @spots = Spot.good.all

  end
  def img
    edit
  end
  def detail
    edit
  end
  def access
    edit
  end
  
  def update_img
    @spot = Spot.find(params[:id])
    respond_to do |format|
      ret = @spot.update_attributes(params[:spot])
      if(ret)
        format.html {  redirect_to :action => 'detail', :notice => 'Spot was successfully updated.' }
      else
        # todo ng時の行き先検討しないとね
        format.html {  render :action => "img" }
      end
    end
  end
  def update_detail
    @spot = Spot.find(params[:id])
    respond_to do |format|
      ret = @spot.update_attributes(params[:spot])
      if(ret)
        format.html {  redirect_to @spot, :notice => 'Spot was successfully updated.' }
      else
        # todo ng時の行き先検討しないとね
        format.html {  render :action => "detail" }
      end
    end
  end
  def update_access
    @spot = Spot.find(params[:id])
    respond_to do |format|
      ret = @spot.update_attributes(params[:spot])
      if(ret)
        format.html {  redirect_to @spot, :notice => 'Spot was successfully updated.' }
      else
        # todo ng時の行き先検討しないとね
        format.html {  render :action => "access" }
      end
    end
  end

end
