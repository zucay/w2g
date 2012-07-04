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
    require 'barby/barcode/qr_code'
    require 'barby/outputter/png_outputter'

    # "ID" text area and QR code are referred to this column.
    id_column = 'linenum'

    @sp = Spot.find(params[:id])
    report = ThinReports::Report.create :layout => File.join(Rails.root, 'doc', 'point_check.tlf') do |r|
      r.start_new_page do |pg|
        %w[name yomi hour park_num park_fee].each do |ele|
          pg.item(ele.to_sym).value(@sp[ele])
        end
        pg.item(:addr).value(@sp.pref.to_s + @sp.city.to_s + @sp.addr.to_s)
        #pg.item(:) #other information

        # map
        url = "http://map.olp.yahooapis.jp/OpenLocalPlatform/V1/static?"
        prms = []
        prms << "appid=#{W2g::Application.config.yappid}"
        prms << "lat=#{@sp.lat_world}"
        prms << "lon=#{@sp.lng_world}"
        prms.concat(%w[z=19 width=800 height=800 base=bold])
        prms << "pindefault=#{@sp.lat_world},#{@sp.lng_world}"
        url = url + prms.join('&')
        p url
        pg.item(:image).src(open(url))
        
        # id
        pg.item(:id).value(@sp[id_column])
        # qr code
        qr_png = Barby::QrCode.new(@sp[id_column].to_s).to_png({:ydim => 5, :xdim => 5})
        pg.item(:qr).src(StringIO.new(qr_png))
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
