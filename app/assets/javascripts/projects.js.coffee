# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require mymap
$( ->
  $( 'tip' ).tipTip();
  $("ul.champagne").champagne({
    beginning_delay: 200,
    delay_between: 200,
    duration: 500,
    onFinish: ->
      alert('finish')
      return
  })

  return
)