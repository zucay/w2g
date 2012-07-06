# -*- coding: utf-8 -*-
require 'fileutils'
require 'loader'
class Spot < ActiveRecord::Base
  serialize :data, Hash
  # relations
  belongs_to :project
  # 2012-07-02 caretaker不要なプロジェクトに対応するためコメントアウト
  #belongs_to :caretaker
  #accepts_nested_attributes_for :caretaker
  has_many :communications
  accepts_nested_attributes_for :communications
  belongs_to :note
  accepts_nested_attributes_for :note
  
  #callbacks
  # 2012-07-02 caretaker不要なプロジェクトに対応するためコメントアウト
  #before_create :build_relation

  before_create :before_create
  #after_initialize :build_relation
  before_update :add_update_flg

  # validations
  validates_presence_of :name, :on => :update, :message => '名称は必ず入力してください'
  validates_format_of :yomi, :on => :update, :with => /^[ァ-タダ-ヶ　ー]*$/, :message => 'ヨミガナは全角カタカナのみで、入力してください'
  validates_format_of :tel, :on => :update, :with => /^[0-9\-]*$/, :message => '電話番号は半角数字で入力してください'
  validates_format_of :pref, :on => :update, :with => /[都道府県]{0,1}$/, :message => '都道府県名のみ入力してください'
  

  # other settings
  picset = {
    :storage => :s3,
    :s3_credentials => W2g::Application.config.S3_CREDENTIALS, 
    :path => ":attachment/:id/:style.:extension",
    :styles => {:small => ["128x128#", :png], :thumb => ["32x32#", :png] },
    :default_url => '/img/no_img.jpg',
  }
  has_attached_file :pic0, picset
  has_attached_file :pic1, picset
  has_attached_file :pic2, picset
  has_attached_file :pic3, picset
  has_attached_file :pic4, picset

  # scope
  scope :deny, where(:deny => true)
  scope :inputed, where(:caretaker_inputed => true, :deny => !true)
  scope :active, where(:active => true, :deny => !true)
  scope :good, lambda {
    active.where('about_body is not null and pic0_file_size > 0').order('pref')
  }

  #attributes that uses the data column
  data_attributes = %w[polyline]
  self.class_eval do
    data_attributes.each do |attr|
      # get method
      define_method(attr.to_sym) do
        p self.class
        out = nil
        if(self.data)
          out = self.data[attr.to_sym]
        end
        return out
      end
      # set method
      define_method((attr + '=').to_sym) do |arg|
        self.data ||= { }
        self.data[attr.to_sym] = arg
      end
    end
  end
  
  #callback methods
  def build_relation
    self.project ||= Project.last
    self.project ||= Project.new
    self.caretaker ||= Caretaker.new
  end
  def before_create
    if(lat_256jp && !lat_world)
      tky2jgd
    end
  end
  
  def add_update_flg
    self.caretaker_inputed = true
  end

  # public instance methods
  def active_column_names
    self.project.header.active_column_names
  end
  def header
    self.project.header
  end
  def set(label, val)
    label_cols = self.header.label_cols
    colname = label_cols[label]
    if(colname)
      self[colname] = val
    else
      if(label =~ /caretaker_(.*)/)
        self.caretaker ||= Caretaker.new
        self.caretaker[$1] = val
      end
      p "Label not found:#{label}"
    end
  end
  def has_img?
    5.times do |i|
      # todo implementation
    end
  end

  def save_img(pic_id = nil, filename = nil)
    pic_id ||= self.main_pic_id
    pic_id ||= 0
    p pic_id
    filename ||= "#{self.name}_#{pic_id}"
    require 'open-uri'
    pic = self.send("pic#{pic_id}")

    read_path = pic.to_s.gsub(/w2g-development/, 'w2g-production')
    write_path = "images/#{filename}#{File.extname(pic.path)}"
    dir = File.dirname(write_path)
    FileUtils.mkdir_p(dir)
    begin
      open(read_path, 'rb') do |fi|
        fo = open(write_path, 'wb')
        fo.write(fi.read)
        fo.close
      end
    rescue => e
      p e
    end
  end
  def tky2jgd
    if(Geoutil.active?)
      Geoutil.ipc2jgd([self], false)
    else
      p "geoutil server is not running."
    end
  end
  def jgd2tky
    if(Geoutil.active?)
      Geoutil.jgd2ipc([self], false)
    else
      p "geoutil server is not running."
    end
  end

  # public class methods
  def self.load(pj_name, file)
    pj = Project.find_by_name(pj_name)
    p pj.name
    ValLoader.load(file, pj)
  end
  def self.backup_img(path = 'images')
    require 'open-uri'
    self.all.each do |sp|
      [sp.pic0, sp.pic1, sp.pic2].each do |pic|
        if(pic.path)
          read_path = pic.to_s.gsub(/w2g-development/, 'w2g-production')
          begin
            open(read_path, 'rb') do |fi|
              write_path = "#{path}/#{pic.path}"
              dir = File.dirname(write_path)
              FileUtils.mkdir_p(dir)
              fo = open(write_path, 'wb')
              fo.write(fi.read)
              fo.close
            end
          rescue => e
            p e
          end
        end
      end
    end
  end

  def self.stat(pj_name)

  end
  # tmp methods
end
