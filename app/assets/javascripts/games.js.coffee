# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  $('.delete_post').bind('ajax:complete', ->
    $(this).closest('div').fadeOut()
    game = $(this).closest('.game')
    if game.find('.user_listing').length == 1
      game.fadeOut()
  )

  $('.comment').hide()

  $('.user_listing h2').bind('hover', ->
    toToggle = $(this).next()
    if toToggle.is(":visible")
      toToggle.hide()
    else
      toToggle.show()
  )
)
