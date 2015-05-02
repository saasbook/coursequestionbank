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
					#dconsole.log($('#all_tags_' + problem_id).text())
					$('#all_tags_' + problem_id).html(data)

	$('[id^="remove_tag"]').click ->
		tag_id = parseInt($(this).parent().attr("id"))
		console.log(tag_id)
		event.preventDefault()