# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class Pointing
  constructor: (div_id) ->
    #地図を初期化
    @map = new Y.Map(div_id, {
      configure :{
        doubleClickPan : true,
        scrollWheelZoom : true
      }
    })

    #コントロールの追加
    @map.addControl(new Y.CenterMarkControl())
    @map.addControl(new Y.SearchControl())
    @map.addControl(new Y.SliderZoomControlHorizontal())

    #地図を表示
    @map.drawMap(new Y.LatLng(35.665627,139.730738), 18,Y.LayerSetId.NORMAL)

    #座標変換オブジェクト
    @cv = new Y.DatumConvert()
    #ジオコーダオブジェクト
    @gc = new Y.GeoCoder()
    #自分をwindowに登録
    window.pt = this
    return

  addMarker: ->
    #マーカーの追加
    if(@marker)
      @map.removeFeature(@marker)
    @marker = new Y.Marker(@map.getCenter())
    this.setLatLng(@map.getCenter())

    @marker.setDraggable(true)
    @marker.pt = this
    @marker.bind('dragend', ->
      this.pt.setLatLng(this.getLatLng())
      return
    )
    @map.addFeature(@marker)
    return @marker

  setLatLng: (_ll) ->
    #引数_ll の座標値をinputタグに流しこむ
    $('input.latlng')[0].value = _ll.lat() + ','+ _ll.lng()
    @cv.convertToTky(_ll, (ydf) ->
      _jpll = ydf.features[0].getLatLng()
      _latlng_jp = _jpll.lat() + ',' + _jpll.lng()
      _latlng_256jp = parseInt(_jpll.lng()*3600*256) + ',' + parseInt(_jpll.lat()*3600*256)
      _latlng_1000jp = parseInt(_jpll.lat()*3600*1000) + ',' + parseInt(_jpll.lng()*3600*1000)

      $('input.latlng_jp')[0].value = _latlng_jp
      $('input.latlng_256jp')[0].value = _latlng_256jp
      $('input.latlng_1000jp')[0].value = _latlng_1000jp
      return
    )
    @map.panTo(_ll, true)
    # 座標値から住所を検索する
    @gc.execute({"latlng":_ll}, (ydf) ->
      _addr = ydf.features[0].property.Address
      $('input.addr')[0].value = _addr
    )

    return

  moveTo: (_type) ->
    _tag = 'input.' + _type
    _str = $(_tag)[0].value
    _ll_raw = _str.split(',')
    _ll = new Y.LatLng(35, 135)
    switch _type
      when "latlng_256jp"
        _lng = parseFloat(_ll_raw[0]) / (256 * 3600)
        _lat = parseFloat(_ll_raw[1]) / (256 * 3600)
        @cv.convertToWgs(new Y.LatLng(_lat, _lng), (ydf) ->
          _ll = ydf.features[0].getLatLng()
          this.pt.setLatLng(_ll)
          return
        )
      when "latlng_jp"
        @cv.convertToWgs(new Y.LatLng(_ll_raw[0], _ll_raw[1]), (ydf) ->
          _ll = ydf.features[0].getLatLng()
          this.pt.setLatLng(_ll)
          return
        )
      when "latlng_1000jp"
        _lat = parseFloat(_ll_raw[0]) / (1000 * 3600)
        _lng = parseFloat(_ll_raw[1]) / (1000 * 3600)
        @cv.convertToWgs(new Y.LatLng(_lat, _lng), (ydf) ->
          _ll = ydf.features[0].getLatLng()
          this.pt.setLatLng(_ll)
          return
        )
      else
        _ll = new Y.LatLng(_ll_raw[0], _ll_raw[1])
        window.pt.setLatLng(_ll)
    return

  deg2dms: (_deg) ->
    _sf = Math.round(_deg * 360000)
    _s  = Math.floor(_sf / 100) % 60
    _m  = Math.floor(_sf / 6000) % 60
    _d = Math.floor(_sf / 360000)
    _sf %= 100;
    if (_m  < 10)
      _m  = "0" + _m
    if (_s  < 10)
      _s  = "0" + _s
    if (_sf < 10)
      _sf = "0" + _sf
    _dms = "" + _d + '.' + _m  + '.' + _s + "." + _sf
    return _dms

  openGmap: ->
    _url = 'https://maps.google.co.jp/maps?hl=ja&q=' + $('input.latlng')[0].value + '&z=18'
    window.open(_url, "new", "width=1024,height=600" )
    return
  openMapfan: ->
    _ll = $('input.latlng_256jp')[0].value.split(",")
    _lat_jp = parseInt(_ll[1]) / (256 * 3600)
    _lng_jp = parseInt(_ll[0]) / (256 * 3600)
    _lat = this.deg2dms(_lat_jp)
    _lng = this.deg2dms(_lng_jp)
    _url = 'http://www.mapfan.com/m.cgi?ZM=13&NFLG=1&MAP=E' + _lng + 'N' + _lat
    window.open(_url, "new", "width=1024,height=800" )
    return
  openItsmo: ->
    _url = 'http://www.its-mo.com/map/detail/' + $('input.latlng_1000jp')[0].value.replace(",", "_")
    window.open(_url, "new", "width=1024,height=800" )
    return
  openMapion: ->
    _url = 'http://www.mapion.co.jp/m/' + $('input.latlng_jp')[0].value.replace(",", "_") + '_10'
    window.open(_url, "new", "width=1024,height=800" )
    return
  copy: (_type) ->
    # IEでしか動作しない
    _tag = 'input.' + _type
    _str = $(_tag)[0].value
    _str = _str.replace(",", "\t")
    window.clipboardData.setData("Text", _str)
    alert('コピーしました:\n' + _str)
    return
window.onload = ->
  window.pt = new Pointing("ymap")
  window.pt.addMarker()
  return



