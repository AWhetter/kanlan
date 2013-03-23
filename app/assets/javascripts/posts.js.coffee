# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  $('.delete_request').bind('ajax:complete', ->
    $(this).closest('div.request').fadeOut()
    game = $(this).closest('.post')
    if game.find('.request').length == 1
      game.fadeOut()
  )

  $('.comment').hide()

  $('.request').bind('hover', ->
    toToggle = $(this).children('.comment')
    if toToggle.is(":visible")
      toToggle.hide()
    else
      toToggle.show()
  )
)
