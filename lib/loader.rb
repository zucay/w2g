# -*- coding: utf-8 -*-
require 'mymatrix'

class Loader
  # xlsのヘッダ名 => ヘッダのラベル名 というハッシュを作成する
  def self.make_header_map(mx, header_instance)
    headers = mx.getHeaders - %w[ID] 
    m_labels = header_instance.labels
    header_map = {}
    headers.each do |h|
      if(m_labels[h].to_s != '')
        header_map[h] = h
      else
        #ヘッダモデルに無い名称の場合の処理
        # caretakerかどうかをチェック
        if(h =~ /^管理_(.*)/)
          # todo 固有の管理情報を決め打ちで埋めこんでいるので柔軟性が低い
          case $1
          when '担当者'
            header_map[h] = 'caretaker_person'
          when 'FAX'
            header_map[h] = 'caretaker_fax'
          else
            p "unmatch header : #{h}"
          end
        else
          # 見つからなかった場合
          p "unmatch header : #{h}"
        end
      end
    end
    # todo monkey patch
    header_map['名称'] = '施設名称'
    header_map['名称ヨミ'] = '施設名称ヨミ'
    header_map['ユニーク項目①：近隣の観光スポット'] = '周辺の観光スポット'
    header_map['ユニーク項目②：見ごろ時期'] = 'あじさいの見頃時期'
    header_map['ユニーク項目③：種類・株数'] = 'あじさいの種類・株数'
    header_map['担当者'] = 'caretaker_person'
    header_map['FAX'] = 'caretaker_fax'
    return header_map
  end
  def self.load(file, project_instance)
    mx = MyMatrix.new(file)
    header_map = self.make_header_map(mx, project_instance.header)
    mx.each do |row|
      # todo 同一性チェックに'ID'という名のExcelカラムを使っている
      mxid = mx.val(row, 'ID').to_i
      begin
        sp = project_instance.spots.find_by_ext_id(mxid)
      rescue
        sp = Spot.new
        sp.project = project_instance
        sp.ext_id = mxid
      end
      header_map.each_pair do |header, label|
        val = mx.val(row, header).gsub(/<br>/, '')
        sp.set(label, val)
      end
      p sp.caretaker
      sp.caretaker.save!
      sp.save!
    end
  end
end

class ValLoader < Loader
end
