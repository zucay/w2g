# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require mymap
$( ->
  $( 'tip' ).tipTip();

  $("ul.champagne_").champagne({
    beginning_delay: 20,
    delay_between: 20,
    duration: 50,
    onFinish: ->
      alert('finish')
      return
  })

  return
)