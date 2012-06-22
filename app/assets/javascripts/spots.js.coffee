# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class MyMap
  constructor: (div_id = 'ymap', lat=35, lng=135) ->
    @map = new Y.Map(div_id, {configure:{scrollWheelZoom:true}})
    @map.addControl(new Y.SearchControl())
    @map.addControl(new Y.SliderZoomControlHorizontal(), Y.ControlPosition.BOTTOM_LEFT)
    @map.addControl(new Y.CenterMarkControl())
    @map.addControl(new Y.LayerSetControl())
    @map.drawMap(new Y.LatLng(lat, lng), 19, Y.LayerSetId.NORMAL)
    return

  addMarker: ->
    #マーカーの追加
    marker = new Y.Marker(@map.getCenter())

    marker.setDraggable(true)
    marker.pt = this
    marker.bind('dragend', ->
      return
    )
    @map.addFeature(marker)
    return marker









window.MyMap = MyMap