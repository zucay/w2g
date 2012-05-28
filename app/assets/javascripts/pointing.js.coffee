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
#    @map.panTo(_ll)
#    setLatLng(_ll)
    return

window.onload = ->
  window.pt = new Pointing("ymap")
  window.pt.addMarker()
  return



