# -*- coding: utf-8 -*-
class Header < ActiveRecord::Base
  has_many :projects
  validates_uniqueness_of :name
  #todo : validates_uniqueness_of *_label

  # override
  def dup
    out = super
    out.name = out.name + "copy_from_#{self.id}"
    out.id = nil
    return out
  end

  def hint(col_name)
    out = []
    # 必須
    if(not_null?(col_name))
      out << " ※必須"
    end
    # 説明
    out << self[col_name + '_desc'].to_s
    # 例
    if(self[col_name + '_example'].to_s != '')
      out << "例：#{self[col_name + '_example']}"
    end
    out.delete('')
    return out.join(' | ')
  end
  def not_null?(col_name)
    return self[col_name + '_not_null']
  end


  def column_names
    out = []
    self.class.column_names.each do |col|
      if(col =~ /(.*)_active$/)
        out << $1
      end
    end
    return out
  end
  def col2label(str)
    self["#{str}_label"]
  end

  def active_column_names
    out = self.column_names.select do |col|
      self[col + '_active'] == true
    end
    out.delete('pic')
    return out
  end

  # label_name => col_name のハッシュを返却する
  def label_cols
    out ={ }
    self.column_names.each do |col|
      label_col = col + '_label'
      if(self[label_col] && self[label_col].to_s != '')
        out[self[label_col]] = col
      end
    end
    return out
  end
end
