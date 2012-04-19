# -*- coding: utf-8 -*-
class Header < ActiveRecord::Base
  has_many :projects

  def hint(col_name)
    example = ''
    if(self[col_name + '_example'].to_s != '')
      example = "例：#{self[col_name + '_example']}　|　"
    end

    out = example + self[col_name + '_desc'].to_s

    if(not_null?(col_name))
      out = out + " ※必須"
    end
    return out
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
  def active_column_names
    self.column_names.select do |col|
      self[col + '_active'] == true
    end
  end
  # ラベル名=>実際のカラム名というハッシュを返却する
  def labels
    out = { }
    self.column_names.select do |col|
      out[self[col + '_label']] = col
    end
    return out
  end
end
