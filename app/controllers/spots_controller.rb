# -*- coding: utf-8 -*-
class SpotsController < InheritedResources::Base
  def imgup
    edit
  end
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
  def img_update
    @spot = Spot.find(params[:id])
    respond_to do |format|
      p params[:spot][:pic0].headers
      p '=================='
      params[:spot][:pic0].headers = params[:spot][:pic0].headers.force_encoding('UTF-8').encode!
      params[:spot][:pic0].original_filename = params[:spot][:pic0].original_filename.force_encoding('UTF-8').encode!


      ret = @spot.update_attributes(params[:spot])

      if(ret)
        format.html {  redirect_to @spot, :notice => 'Spot was successfully updated.' }
      else
        # todo ng時の行き先検討しないとね
        format.html {  render :action => "edit" }
      end
    end
  end
end
