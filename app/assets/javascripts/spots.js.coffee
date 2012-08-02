#= require mymap
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class DistanceMap extends MyMap
  constructor: (@appid, @div_id = 'ymap', @distance_selector = 'input.distance', lat = 35.627832181966376, lng = 139.62137897404472) ->

    super(@appid, @div_id, lat, lng)
    @points = []
    # ダブルクリックで線を引く
    @map.bind("dblclick", (latlng) =>
      @points.push(latlng)
      if(@points.length >= 2)
        this.drawPolyline(@points)
        this.getDistance(distance_selector)
    )
    #地図を動かしたとき、中心座標を表示する
    @map.bind("moveend", =>
      ll = @map.getCenter()
      #alert(ll)
      $('input.latlng')[0].value = ll.lat() + ',' + ll.lng()
    )
    $('#' + @div_id).mousemove( =>
      this.getDistance(@distance_selector)
    )
    return

  addMarker:(latlng = null) =>
    super(latlng)
    this.getDistanceFromMarker(distance_selector)
    return


window.DistanceMap = DistanceMap
