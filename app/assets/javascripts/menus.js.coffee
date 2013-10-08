$ ->

  $(document).on 'mouseover', '#right-menu', ->
  	$("#right-menu").stop()
  	$("#right-menu").animate(width: "200px", 700)

  $(document).on "mouseout", "#right-menu", ->
    $("#right-menu").stop()
    $("#right-menu").animate(width: "5px", 700)


  $(document).on 'mouseover', '#top-menu', ->
  	$("#top-menu").stop()
  	$("#top-menu").animate(top: "2px", 500)

  $(document).on "mouseout", "#top-menu", ->
    $("#top-menu").stop()
    $("#top-menu").animate(top: "-46px", 500)




