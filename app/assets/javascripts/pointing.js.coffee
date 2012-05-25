# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class Pointing
  constructor: (div_id) ->
    #地図を初期化
    @map = new Y.Map(div_id, {
      configure :{doubleClickPan : true}
    })

    #コントロールの追加
    @map.addControl(new Y.LayerSetControl())
    @map.addControl(new Y.ZoomControl())
    #map.addControl(new Y.CenterMarkControl())
    @map.addControl(new Y.ScaleControl())
    @map.addControl(new Y.SearchControl())

    #地図を表示
    @map.drawMap(new Y.LatLng(35.665627,139.730738), 18,Y.LayerSetId.NORMAL)
    return

  addMarker: ->
    #マーカーの追加
    _marker = new Y.Marker(@map.getCenter())
    _marker.setDraggable(true)
    _marker.bind('dragend', ->
      _ll = this.getLatLng()
      $('div.lat').text(_ll.lat())
      $('div.lng').text(_ll.lng())
      _cv = new Y.DatumConvert()
      _cv.convertToTky(_ll, (ydf) ->
        _jpll = ydf.features[0].getLatLng()
        $('div.lat_jp').text(_jpll.lat())
        $('div.lng_jp').text(_jpll.lng())
        $('div.lat_256jp').text(parseInt(_jpll.lat() * 3600 * 256))
        $('div.lng_256jp').text(parseInt(_jpll.lng() * 3600 * 256))
        $('div.lat_1000jp').text(parseInt(_jpll.lat() * 3600 * 1000))
        $('div.lng_1000jp').text(parseInt(_jpll.lng() * 3600 * 1000))

      )


      return
    )




    @map.addFeature(_marker)
    return _marker

  marker_move: ->
    alert('hoge')
    #_ll = this.getLatLng()
    #alert(_ll)


window.onload = ->
  a = new Pointing("ymap")
  a.addMarker()




