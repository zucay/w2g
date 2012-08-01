class MyMap
  constructor: (@div_id = 'ymap', lat=35, lng=135, zoom=19) ->
    @map = new Y.Map(div_id, {
      configure:{
        scrollWheelZoom:true
      }
    })
    @ctl_search = new Y.SearchControl()
    @map.addControl(@ctl_search)
    @ctl_centerMark = new Y.CenterMarkControl()
    #@map.addControl(@ctl_centerMark)
    @map.addControl(new Y.SliderZoomControlHorizontal(), Y.ControlPosition.BOTTOM_LEFT)
    @map.addControl(new Y.LayerSetControl())
    @map.drawMap(new Y.LatLng(lat, lng), zoom, Y.LayerSetId.NORMAL)
    @line = null
    #座標変換オブジェクト
    @cv = new Y.DatumConvert()
    return this
  setAppId: (appid) ->
    @appid = appid
    return

  # 日本全体が表示されるメソッド
  drawJapan: ->
    ll = new Y.LatLng(38.4960200019787,139.79665596874977)
    zoom = 6
    @map.setZoom(zoom, true, ll, ll)
    return
  # 本州主要部が表示されるメソッド
  drawHonshu: ->
    ll = new Y.LatLng(35.77215628582593,137.72279044844072)
    zoom = 8
    @map.setZoom(zoom, true, ll, ll)
    return
  # 関東主要部が表示されるメソッド
  drawKanto: ->
    ll = new Y.LatLng(35.677079613937174,139.7369607249153)
    zoom = 10
    @map.setZoom(zoom, true, ll, ll)
    return


  # サーチコントロールの表示
  showSearch: ->
    @map.addControl(@ctl_search)
    return
  # サーチコントロールの非表示
  hideSearch: ->
    @map.removeControl(@ctl_search)
    return
  # センターマーカーの表示
  showCenterMark: ->
    @map.addControl(@ctl_centerMark)
    return
  # センターマーカーの非表示
  hideCenterMark: ->
    @map.removeControl(@ctl_centerMark)
    return


  # マーカーの追加
  addMarker:(lat, lng, opts=null) ->
    if(!opts)
      opts = {}
    opts['clickable'] = true
    marker = new Y.Marker(new Y.LatLng(lat,lng), opts)
    @map.addFeature(marker)
    return marker
  # クリックするとリンク先に飛ぶマーカー
  addLinkMarker:(lat, lng, url, opts=null) ->
    marker = this.addMarker(lat,lng,opts)
    marker.bind('click', ->
      document.location = url
    )
    return marker

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

# ポインティングのためのクラス
class SinglePointingMap extends MyMap
  # addMarkerという名前が良くない。
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
  onMarkerClick: ->
    return
  onMarkerDragEnd: ->
    return


window.MyMap = MyMap