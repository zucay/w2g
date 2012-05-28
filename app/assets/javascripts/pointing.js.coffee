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
    $('input.latlng')[0].value = _ll.lat() + ', '+ _ll.lng()

    _cv = new Y.DatumConvert()
    _cv.convertToTky(_ll, (ydf) ->
      _jpll = ydf.features[0].getLatLng()
      _latlng_jp = _jpll.lat() + ', ' + _jpll.lng()
      _latlng_256jp = parseInt(_jpll.lng()*3600*256) + ', ' + parseInt(_jpll.lat()*3600*256)
      _latlng_1000jp = parseInt(_jpll.lat()*3600*1000) + ', ' + parseInt(_jpll.lng()*3600*1000)

      $('input.latlng_jp')[0].value = _latlng_jp
      $('input.latlng_256jp')[0].value = _latlng_256jp
      $('input.latlng_1000jp')[0].value = _latlng_1000jp
      return
    )
    return



window.onload = ->
  window.pt = new Pointing("ymap")
  window.pt.addMarker()
  return



