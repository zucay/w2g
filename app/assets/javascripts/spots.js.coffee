# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class MyMap
  constructor: (appid, div_id = 'ymap', lat=35, lng=135) ->
    @appid = appid
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

    # ダブルクリックでマーカー追加
    @map.bind("dblclick", (latlng) =>
      this.addMarker(latlng)
      )
    return

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


  getMarkers: ->
    out = []
    features = @map.getFeatures()
    for feature in features
      if(feature.constructor == Y.Marker)
        out.push(feature)
    #alert(out.length + " markers")
    return out

  getDistance: (features, selector = null) ->
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

  getDistanceFromMarker: (selector = null)->
    this.getDistance(this.getMarkers(), selector)
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

class DistanceMap extends MyMap
  constructor: (appid, div_id = 'ymap', lat = 35.627832181966376, lng = 139.62137897404472) ->
    super(appid, div_id, lat, lng)
    @map.bind("moveend", =>
      ll = @map.getCenter()
      #alert(ll)
      $('input.latlng')[0].value = ll.lat() + ',' + ll.lng()
    )
    return

    addMarker:(latlng = null) =>
    super(latlng)
    this.getDistanceFromMarker('input.distance')
    return


#window.MyMap = MyMap
window.MyMap = DistanceMap