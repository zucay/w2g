# -*- coding: utf-8 -*-
require 'loader'
class Spot < ActiveRecord::Base
  # relations
  belongs_to :project
  belongs_to :caretaker
  accepts_nested_attributes_for :caretaker
  has_many :communications
  accepts_nested_attributes_for :communications
  belongs_to :note
  accepts_nested_attributes_for :note
  
  #callbacks
  #before_create :build_relation
  after_initialize :build_relation
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


  #callback methods
  def build_relation
    self.project ||= Project.last
    self.project ||= Project.new
    self.caretaker ||= Caretaker.new
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
  
  # public class methods
  def self.load(pj_name, file)
    pj = Project.find_by_name(pj_name)
    p pj.name
    ValLoader.load(file, pj)
  end
  # tmp methods

end
