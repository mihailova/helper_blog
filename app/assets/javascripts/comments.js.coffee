# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->

  $(document).on 'click', '.rating span', ->
  	rating = $(this).attr("value")
  	$("#comment_rating").val(rating)
  	$(this).addClass('selected')

  $(document).on 'click', '.rating span.selected', ->
  	$('.rating span.selected').removeClass('selected')

  $(document).on 'mouseover', '#comments .comment .well', ->
  	$(this).find('.controls').show()

  $(document).on 'mouseout', '#comments .comment .well', ->
  	$(this).find('.controls').hide()