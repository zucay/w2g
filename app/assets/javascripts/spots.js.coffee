# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class MyMap
  constructor: (@appid, @div_id = 'ymap', lat=35, lng=135) ->
    @map = new Y.Map(div_id, {
      configure:{
        scrollWheelZoom:true
      }
    })
    @map.addControl(new Y.SearchControl())
    @map.addControl(new Y.SliderZoomControlHorizontal(), Y.ControlPosition.BOTTOM_LEFT)
    @map.addControl(new Y.CenterMarkControl())
    @map.addControl(new Y.LayerSetControl())
    @map.drawMap(new Y.LatLng(lat, lng), 19, Y.LayerSetId.NORMAL)
    @line = null
    #座標変換オブジェクト
    @cv = new Y.DatumConvert()
    return this

  ll256jpToWorld: (lat_256jp, lng_256jp, callback) ->
    latjp = parseFloat(lat_256jp) / (256 * 3600)
    lngjp = parseFloat(lng_256jp) / (256 * 3600)
    @cv.convertToWgs(new Y.LatLng(_lat, _lng), (ydf) ->
      ll = ydf.features[0].getLatLng()
      callback(ll.lat(), ll.lng())
      return
    )
    return
  ll256jpToCenter: (lat_256jp, lng_256jp) ->
    ll256jpToWorld(lat_256jp, lng_256jp, (lat, lng)=>
      alert(lat + ', ' + lng)
      @map.panTo(new Y.LatLng(lat, lng))
      return
      )
    return

  drawPolyline:(latlngs, callback=null) ->
    #alert(latlngs)
    if(@line)
      @map.removeFeature(@line)
      @line = null

    @line = new Y.Polyline(latlngs)
    @line.setDraggable(true)
    @map.addFeature(@line)

    return @line


  addMarker:(latlng = null) ->
    if !latlng
      latlng = @map.getCenter()
    marker = new Y.Marker(latlng)

    marker.setDraggable(true)
    marker.pt = this
    marker.bind('dragend', this.onMarkerDragEnd)
    marker.bind('click', this.onMarkerClick)

    @map.addFeature(marker)
    return marker

  getFeatures: (class_obj) ->
    out = []
    features = @map.getFeatures()
    for feature in features
      if(feature.constructor == class_obj)
        out.push(feature)
    #alert(out.length + " markers")
    return out

  getMarkers: ->
    out = this.getFeatures(Y.Marker)
    return out

  getDistance: (selector = null) ->
    out = 0
    if(@line)
      out = @line.getLength()
      if selector
        $(selector)[0].value = out
    return out

  getDistanceFromFeatures: (features, selector = null) ->
    out = 0.0
    url = "http://distance.search.olp.yahooapis.jp/OpenLocalPlatform/V1/distance?" + "appid=" + @appid
    url = url + "&coordinates="
    ll = features[0].getLatLng()
    for feature, i in features
      if(i != 0)
        dest_ll = feature.getLatLng()
        out = out + ll.distance(dest_ll)
        ll = dest_ll
    #alert(out)
    if selector
      cut = parseInt(out * 1000) / 1000
      $(selector)[0].value = cut
    return out

  getDistanceFromMarkers: (selector = null)->
    this.getDistanceFromFeatures(this.getMarkers(), selector)
    return

  onMarkerClick: ->
    return

  onMarkerDragEnd: ->
    return

  panTo: (selector) ->
    str_ll = $(selector)[0].value.split(',')
    ll = new Y.LatLng(str_ll[0], str_ll[1])
    @map.panTo(ll, true)
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


window.MyMap = MyMap
window.DistanceMap = DistanceMap