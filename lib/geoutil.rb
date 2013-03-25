# -*- coding: utf-8 -*-
require 'restproc'
require 'mymatrix'
require 'json'
class Geoutil
  #GEOURL = 'http://192.168.11.88:4000/tky2jgd.json'
  GEOURL = 'http://localhost:4000/tky2jgd.json'
  def self.active?
    out = true
    begin
      open(GEOURL)
    rescue
      out = false
    end
    return out
  end

  def self.ipc2jgd(records)
    rpc = Restproc.new(GEOURL)
    siz = records.size
    records.each_with_index do |record, i|
      if(siz > 100 && i%100 == 0)
        p "#{i+1}/#{siz}"
      end
      latlng = "#{record.lat_256jp},#{record.lng_256jp}"
      begin
        ret = rpc.call('tky2jgd.json', {'latlng' => latlng, 'type' => 'ipc2jgd'})
      rescue => e
        p "exception at #{i}:#{latlng}: #{e}"
      end
      if(ret[0] && ret[0] > 20)
        record.lat_world = ret[0]
        record.lng_world = ret[1]
        record.save
      else
        #raise "return value error.#{ret[0]}, #{ret[1]}"
      end
    end
  end
  
  def self.jgd2ipc(records)
    rpc = Restproc.new(GEOURL)
    siz = records.size
    records.each_with_index do |record, i|
      if(siz > 100 && i%100 == 0)
        p "#{i}/#{siz}"
      end
      latlng = "#{record.lat_world},#{record.lng_world}"
      begin
        ret = rpc.call('tky2jgd.json', {'latlng' => latlng, 'type' => 'jgd2ipc'})
      rescue => e
        p "exception at #{i}:#{latlng}: #{e}"
      end
      if(ret[0] > 10000)
      else
        raise "return value error.#{ret[0]}, #{ret[1]}"
      end
      record.lat_256jp = ret[0]
      record.lng_256jp = ret[1]
      record.save
    end
  end
  def self.ipc2jgdFile(file)
    
    mx = MyMatrix.new(file)
    omx = mx.empty
    rpc = Restproc.new(GEOURL)
    siz = mx.size
    mx.each_with_index do |row, i|
      if(siz > 100 && i%100 == 0)
        p "#{i+1}/#{siz}"
      end
      latlng = "#{mx.val(row, 'lat')},#{mx.val(row,'lng')}"
      ret = rpc.call('tky2jgd.json', {'latlng' => latlng, 'type' => 'ipc2jgd'})
      orow = []
      if(ret[0] && ret[0] > 20)
        omx.setValue(orow, 'lat', ret[0])
        omx.setValue(orow, 'lng', ret[1])
      else
        p "#{i+1}:return value error.#{ret[0]}, #{ret[1]}"
        orow = []
        omx.setValue(orow, 'lat', '0')
        omx.setValue(orow, 'lng', '0')
        #raise "return value error.#{ret[0]}, #{ret[1]}"
      end
      omx << orow
    end
    omx.to_t_with('ipc2jgd')
  end
  def self.cities(pref)
    rpc = Restproc.new(GEOURL)
    rpc.call('addr/cities', 'pref' => '東京都')
  end
  def self.prefs
    %w[北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県 茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県 新潟県 富山県 石川県 福井県 山梨県 長野県 岐阜県 静岡県 愛知県 三重県 滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県 鳥取県 島根県 岡山県 広島県 山口県 徳島県 香川県 愛媛県 高知県 福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県]
  end
  def self.getGid(name, lat_world, lng_world, addr=nil, phone=nil)
    #名称と緯度経度は必須
    if(!name || !lat_world || !lng_world)
      raise 'name, lat_world or lng_world is null.'
    end
    out = 'N/A'
    appid = 'b1LX0ISxg64jnxUZn73laMdd35VPW8rMKVcUHgMAFmJRKmIKblfhFU0gZwUIVA--'
    url = "http://storage.olp.yahooapis.jp/OpenLocalPlatform/V1/getGid?appid=#{appid}&name=#{name}&lat=#{lat_world}&lon=#{lng_world}&address=#{addr}&phone=#{phone}"
    encUrl = URI.encode(url)
    #sleep(0.5)
    begin
      rnode = Nokogiri::XML::parse(open(encUrl).read)
      gids = rnode.css('Gid')
      if gids.size > 0
        out = gids[0].text
      end
    rescue => e
      p "#{e}|#{url}"
    end
    return out
  end
end
class GeoUtil < Geoutil
end
