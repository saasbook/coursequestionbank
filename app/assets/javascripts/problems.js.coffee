# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


@myfunction = (problemid, collectionid) ->
    $.ajax({url: "/add_problem?collection_id=#{collectionid}&id=#{problemid}"}).done (data) -> 
      if data["status"] == true
        alert("Successfully added question to collection!")
      else
        alert("You failed to add question")