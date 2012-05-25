# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onload = ->
        #地図を初期化
        map = new Y.Map("ymap", {
                configure :{doubleClickPan : true}
        })

        #コントロールの追加
        map.addControl(new Y.LayerSetControl())
        map.addControl(new Y.ZoomControl())
        #map.addControl(new Y.CenterMarkControl())
        map.addControl(new Y.ScaleControl())
        map.addControl(new Y.SearchControl())

        #地図を表示
        map.drawMap(new Y.LatLng(35.665627,139.730738), 18,Y.LayerSetId.NORMAL)

        #マーカーの追加
        marker = new Y.Marker(map.getCenter())
        marker.setDraggable(true)

        map.addFeature(marker)

        return
