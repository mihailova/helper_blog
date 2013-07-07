# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.post textarea').wysihtml5
    'font-styles': true
    emphasis: true
    lists: true
    html: true
    link: true
    image: true
    color: true