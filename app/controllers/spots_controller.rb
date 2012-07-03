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
  def pdf
    @sp = Spot.find(params[:id])
    report = ThinReports::Report.create :layout => File.join(Rails.root, 'doc', 'point_check.tlf') do |r|
      r.start_new_page do |pg|
        pg.item(:name).value(@sp.name)
        pg.item(:yomi).value(@sp.yomi)
        pg.item(:addr).value(@sp.pref + @sp.city + @sp.addr)
        pg.item(:hour).value(@sp.hour)
        pg.item(:park_num).value(@sp.park_num)
        pg.item(:park_fee).value(@sp.park_fee)
        #pg.item(:) #other information
        url = "http://map.olp.yahooapis.jp/OpenLocalPlatform/V1/static?"
        prms = []
        prms << "appid=#{W2g::Application.config.yappid}"
        prms << "lat=#{@sp.lat_world}"
        prms << "lon=#{@sp.lng_world}"
        prms.concat(%w[z=19 width=1024 height=1024 base=vivid])
        url = url + prms.join('&')
        p url
        pg.item(:image).src(open(url))
      end
    end
    send_data report.generate, :filename => "#{@sp.linenum}.pdf", :type => 'application/pdf', :disposition => 'attachment'

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
