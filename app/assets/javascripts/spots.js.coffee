# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Ale
        alert: ->
          console.log('hoge')
class MyMap
        constructor: (lat=35, lng=135) ->
                @ymap = new Y.Map("ymap", {configure:{scrollWheelZoom:true}})
                @ymap.addControl(new Y.SearchControl())
                @ymap.addControl(new Y.SliderZoomControlHorizontal(), Y.ControlPosition.BOTTOM_LEFT)
                @ymap.addControl(new Y.CenterMarkControl())
                @ymap.addControl(new Y.LayerSetControl())
        draw: ->
                @ymap.drawMap(new Y.LatLng(lat, lng), 19, Y.LayerSetId.NORMAL)
        alert: ->
                alert('hoge')
