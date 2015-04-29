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
	$('#add_tags').on "keypress", (event) ->
		if event.which == 44
			tag = $('#add_tags').val()
			console.log(tag)
			$("<span class='tags'>" + tag + "</span>").insertAfter("#add_tags");
			$('#add_tags').val('');
			event.preventDefault();