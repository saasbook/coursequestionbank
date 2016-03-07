# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@myfunction = (problemid, collectionid) ->
    $.ajax({url: "/add_problem?collection_id=#{collectionid}&id=#{problemid}"}).done (data) ->
      if data["status"] == true
        alert("Successfully added question to collection!")
      else
        alert("You failed to add question")


$(document).ready ->
  $('[id^="add_tags_"]').on "keypress", (event) ->
    if event.which == 44
      tag = $(this).val().trim()
      tag_id = $(this).parent().attr("id")
      problem_id = parseInt(tag_id, 10)
      #$("<span class='tag'>" + tag + "</span>").insertAfter(this)
      $(this).val('')
      event.preventDefault()
      $.ajax
        url: "add/" + tag + "/to/problem/" + problem_id
        success: (data, textStatus, jqXHR) ->
          $('#all_tags_' + problem_id).html(data)

  @clickHandler = $('body').on "click", '[id^="remove_tag"]', (event) ->
    console.log("fn called")
    tag_id = parseInt($(this).parent().attr("id"))
    pid = parseInt($(this).parent().parent().parent().attr("id"))
    $.ajax
      url: "remove/" + tag_id + "/from/problem/" + pid
      success: (data, textStatus, jqXHR) ->
        $('#all_tags_' + pid).html(data)
    event.preventDefault()
