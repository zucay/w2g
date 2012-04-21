# -*- coding: utf-8 -*-
class SpotsController < InheritedResources::Base
  def self.myforce_encode(hash)
    out = { }
    hash.each_pair do  |k,v|
      if(v.class == Hash)
        out[k] = force_encode(v)
      elsif
        out[k] = v.force_encoding('UTF-8')
      else
        out[k] = v
      end
    end
    return out
  end
  def img
    edit
  end
  def detail
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
end
