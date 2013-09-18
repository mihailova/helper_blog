# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
num_of_pics=0
$ ->
  $('#add_comment').click () ->
    $(this).addClass("invisible")
    $('#new-comment').removeClass("invisible")

  $(".chosen-select").chosen()
  $('.post textarea#post_text').wysihtml5
    'font-styles': true
    emphasis: true
    lists: true
    html: true
    link: true
    image: true
    color: true

$ ->
  $("#add-picture").click (e) ->
  	e.preventDefault()
  	$('.pictures').append(upload_template(num_of_pics))
  	num_of_pics++

upload_template = (index) ->
  '<input id="post_pictures_' + index + '" name="post[pictures_attributes][' + index + '][image]" type="file">' + 
  '<div class="input string optional"><label class="string optional" for="post_pictures_attributes_' + index + '_caption"> Caption</label>' +
  '<input class="string optional" id="post_pictures_attributes_' + index + '_caption" maxlength="255" name="post[pictures_attributes][' + index + '][caption]" size="50" type="text"></div>'
