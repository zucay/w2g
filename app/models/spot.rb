# -*- coding: utf-8 -*-
class Spot < ActiveRecord::Base
  belongs_to :project
  has_many :caretakers
  accepts_nested_attributes_for :caretakers
  has_many :communications
  accepts_nested_attributes_for :communications


  validates_presence_of :name, :on => :update, :message => '名称は必ず入力してください'
  validates_format_of :yomi, :on => :update, :with => /^[ァ-タダ-ヶ　ー]+$/, :message => 'ヨミガナは全角カタカナのみで、入力してください'
  #validates_format_of :tel, :on => :update, :with => /^[0-9\-]*$/, :message => '電話番号は半角数字で入力してください'
  validates_format_of :pref, :on => :update, :with => /[都道府県]$/, :message => '都道府県名のみ入力してください'
  


  has_attached_file :pic0, :storage => :s3,:s3_credentials => W2g::Application.config.S3_CREDENTIALS, :path => ":attachment/:id/:style.:extension"
  has_attached_file :pic1, :storage => :s3,:s3_credentials => W2g::Application.config.S3_CREDENTIALS, :path => ":attachment/:id/:style.:extension"
  has_attached_file :pic2, :storage => :s3,:s3_credentials => W2g::Application.config.S3_CREDENTIALS, :path => ":attachment/:id/:style.:extension"
  has_attached_file :pic3, :storage => :s3,:s3_credentials => W2g::Application.config.S3_CREDENTIALS, :path => ":attachment/:id/:style.:extension"
  has_attached_file :pic4, :storage => :s3,:s3_credentials => W2g::Application.config.S3_CREDENTIALS, :path => ":attachment/:id/:style.:extension"
  def active_column_names
    self.project.header.active_column_names
  end
  def header
    self.project.header
  end
end
