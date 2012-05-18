# -*- coding: utf-8 -*-
require 'mymatrix'

class Output
  # テキストを出力する
  def self.to_t_core(proj)
    name = self.make_file_name(proj)
    mx = MyMatrix.new
    mx.addHeaders(self.make_header(proj))
    self.get_spots(proj).each_with_index do |sp, i|
      n = i + 1
      row = yield(sp,n)
      mx << row
    end
    mx.to_t(name)
  end
  # 画像を出力する
  def self.to_img_core(proj)
    self.get_spots(proj).each_with_index do |sp, i|
      #pathを返却する
      n = i + 1
      path = yield(sp, n)
      sp.save_img(0, path)
    end
  end
  
  def self.get_spots(proj)
    proj.spots.active.order('govcode')
  end
  def self.make_file_name(proj)
    #小クラスで実装推奨
    date = Date.today.to_s
    out = "#{date}_#{proj.name}.txt"
    return out
  end
  def self.make_header(proj)
    #小クラスで実装必須
    %w[spot_id name pref addr]
  end
  def self.to_t(proj)
    #小クラスで実装必須
    self.to_t_core(proj) do |sp, n|
      [n, sp.name, sp.pref, sp.addr]
    end
  end
  def self.to_img(proj)
    #小クラスで実装推奨
    self.to_img_core(proj) do |sp, n|
      # sp.save_imgのデフォルト処理をする
      nil
    end
  end
end

class ValOutput < Output
  def self.park(sp)
    out = 'なし'
    if(sp.has_park)
      detail = ([sp.park_num, sp.park_fee] - ['']).join('／')
      out = "あり（#{detail}）"
    end
    return out
  end
  def self.make_header(proj)
    out = %w[ID 名称 名称ヨミ 都道府県 残り住所 電話番号 問合わせ先 営業期間／営業時間 休業日 駐車場の有無／台数 アクセス電車 アクセス車 料金 HPアドレス 紹介文（100～200文字） 緯度（日本測地系ミリ秒） 経度（日本測地系ミリ秒） 画像ファイル名]
    out << 'ユニーク項目①　' + proj.header.info_0_label
    out << 'ユニーク項目②　' + proj.header.info_1_label
    out << 'ユニーク項目③　' + proj.header.info_2_label
    return out
  end
  def self.to_t(proj)
    #小クラスで実装必須
    self.to_t_core(proj) do |sp, n|

      extid = sprintf("%04d", n)
      extid = sp.id
      [extid, sp.name, sp.yomi, sp.pref, sp.addr, sp.tel, sp.tel_info, sp.hour, sp.holiday, self.park(sp),
       sp.access_train, sp.access_car, sp.spot_fee, sp.url,
       # 紹介文
       sp.about_body,
       # 座標
       ((sp.lat_256jp.to_i * 1000)/ 256).to_i.to_s,
       #sp.lat_256jp,
       ((sp.lng_256jp.to_i * 1000)/ 256).to_i.to_s,
       #sp.lng_256jp,
       # 画像
       sprintf("%04d.jpg", n),
       sp.info_0,
       sp.info_1,
       sp.info_2,
      ]
    end
  end
  def self.to_img(proj)
    #小クラスで実装推奨
    self.to_img_core(proj) do |sp, n|
      "#{n}_#{sp.name}"
      #n
    end
  end

end


