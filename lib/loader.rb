# -*- coding: utf-8 -*-
require 'mymatrix'

class Loader
  def make_header_map(mx, header_instance)
    headers = mx.getHeaders
    m_labels = header_instance.labels
    header_map = {}
    headers.each do |h|
      if(m_labels[h].to_s != '')
        header_map[h] = m_labels[h]
      else
        #ヘッダモデルに無い名称の場合は、caretakerかどうかをチェック
        #固有の管理情報を決め打ちで埋めこんでいるので柔軟性が低い
        if(h =~ /^管理_(名称|担当者)/)
          case $1
          when '名称'
          when '担当者'
          else
          end
        else
          #yield(h)
          p "unmatch header : #{h}"
        end
      end
    end
    return header_map
  end
  def self.load(file, header_instance)
    mx = MyMatrix.new(file)
    header_map = make_header_map(mx, header_instance)
    mx.each do |row|
      
    end
  end
  
end

class ValLoader < Loader
end
