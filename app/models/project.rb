# -*- coding: utf-8 -*-
require 'mymatrix'
require 'citycode'
require 'output'
require 'geoutil'
require 'open-uri'
require 'readerwriter'

class Project < ActiveRecord::Base
  has_many :spots
  belongs_to :header
  validates_presence_of :project
  scope :public, where('public = ?', true)
  scope :active, where('active = ?', true)
  scope :with_genre, lambda{|v| where('genre = ?', v)}
  s3set = {
    :storage => :s3,
    :s3_credentials => W2g::Application.config.S3_CREDENTIALS, 
    :path => ":attachment/:id.:extension"
  }
  has_attached_file :base_file, s3set
  
  # override
  def dup
    out = super
    out.header = out.header.dup
    out.name = out.name + "copy_from_#{self.id}"
    out.id = nil
    return out
  end

  def gov_coding
    spots = self.spots
    spots.each do |sp|
      cc = Citycode.new
      query = sp.pref + sp.addr
      govcode = cc.getCodeAndSplitAddr(query)[0]
      if(govcode)
        p govcode
        sp.govcode = govcode
        sp.save!
      else
        p "govcode notfound: #{sp.id} #{sp.name}"
      end
    end
  end
  def load(file = nil)
    ReaderWriter.read(self, file)
  end
  def force_load(file = nil)
    self.spots.destroy_all
    load(file)
  end

#formatter
  # nameとtel_infoが同一の場合、tel_infoを削除する
  def tel_info_clean
    spots = self.spots
    spots = spots.where("name = tel_info")
    spots.each do |sp|
      sp.tel_info = ''
      sp.save!
    end
  end
  # 半角カナを全角にし、全角数字と一部記号を半角にする
  def self.num_format(str)
    out = nil
    if(str)
      out = NKF::nkf('-WwXm0Z0', str)
      out = out.gsub(/[~[\u301c]]/, '～')
      out = out.gsub(/</, '＜')
      out = out.gsub(/>/, '＞')

    end
    return out
  end
  def format(col_name)
    spots = self.spots
    spots.each do |sp|
      out = Project.num_format(sp[col_name])
      p "#{sp[col_name]}=>#{out}"
      sp[col_name]= out
      sp.save!
    end
  end
  def val_format
    %w[addr hour holiday spot_fee park_num park_fee access_train access_car info_0 info_1 info_2 info_3].each do |col|
      format(col)
    end
  end
  def holiday_format
    spots = self.spots
    spots.each do |sp|
      org = sp.holiday.dup
      if(sp.holiday =~ /^(無し|なし|無休|入場自由)$/)
        sp.holiday = '無休'
      end
      #p "#{org} => #{sp.holiday}"
      sp.save!
    end
  end
  def hour_format
    spots = self.spots
    spots.each do |sp|
      org = sp.hour.to_s.dup
      if(sp.hour =~ /^(無し|なし|無休|入場自由)$/)
        sp.hour = '常時'
      end
      #p "#{org} => #{sp.hour}"
      sp.save!
    end
  end
  def fee_format
    spots = self.spots
    spots.each do |sp|
      org = sp.spot_fee.to_s.dup
      if(sp.spot_fee =~ /^(無し|なし)$/)
        sp.spot_fee = '無料'
      end
      #p "#{org} => #{sp.spot_fee}"
      sp.save!
    end
  end
  def access_train_format
    spots = self.spots
    spots.each do |sp|

      org = sp.access_train.to_s.dup
      mod = org.gsub(/(.*)から(徒歩|バス|タクシー)(.*)/, '\1より\2\3')
      mod = mod.gsub(/(\d+)(時|分)/, '約\1\2')
      mod = mod.gsub(/約+/, '約')
      #p "#{org} => #{mod}"
      sp.access_train = mod
      sp.save!
    end
  end
  def access_car_format
    spots = self.spots
    spots.each do |sp|

      org = sp.access_car.to_s.dup
      mod = org.gsub(/ICから/, 'ICより')
      mod = mod.gsub(/方面へ/, '方面に')
      mod = mod.gsub(/Km/, 'km')
      mod = mod.gsub(/㎞/, 'km')

      #p "#{org} => #{mod}"
      sp.access_car = mod
      sp.save!
    end
  end

  def add_active
    spots = self.spots
    spots = spots.where("pic0_file_name is not null or pic0_file_name <> ''")
    spots.each do |sp|
      sp.active = true
      sp.save!
    end
  end
  def to_t_val
    ValOutput.to_t(self)
    p 'saving image..'
    ValOutput.to_img(self)
  end
  def tky2jgd
    Geoutil.ipc2jgd(self.spots)
  end
  def jgd2tky
    Geoutil.jgd2ipc(self.spots)
  end
  def check_url
    require 'open-uri'
    spots = self.spots.active
    spots.each do |sp|

      url = sp.url
      if(url)
        begin
          open(url).read
        rescue => e
          p "#{sp.id}_#{sp.name} #{sp.url}"
          p "NG:#{e}"
        end
      end
    end
  end
  
  def self.exec(proj_id, cmd, *args)
    pj = Project.find(proj_id)
    pj.send(cmd, *args)
  end

end
