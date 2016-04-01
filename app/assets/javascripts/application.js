// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap-sprockets
//= require zeroclipboard

jQuery(document).ready(function() {
	// $('.maintable').find('.answers').hide(); //Hide/close all containers
	// $('.maintable').find('.additional').hide();
	// $('.text').addClass('toggler').removeClass('text');
	// $('.maintable').find('.toggler').addClass('text').removeClass('toggler');
	// $('.icon').click(function(){

	// 	$('#q' + $(this).attr('id')).find('.answers').toggle();
	// 	$('#q' + $(this).attr('id')).find('.additional').toggle();
	// 	$('#q' + $(this).attr('id')).find('.text, .toggler').toggleClass("text toggler");
	// 	$('#q' + $(this).attr('id')).find('.colname, .toggler2').toggleClass("colname toggler2");
	// 	$(this).toggleClass("glyphicon glyphicon-chevron-right icon glyphicon glyphicon-chevron-down icon")
	// 	$('#q' + $(this).attr('id')).find('.colname, .toggler2').toggleClass("colname toggler2");
	// });

	$('.d_clip_button').show();
	var clip = new ZeroClipboard($('.d_clip_button'));
	$(".d_clip_button").on("click", function(){
		alert("Source code copied to clipboard!");
	});
	
	$('.check_all').show();
	$('.check_all').change(function () {
		var group = $(this).attr('id').substring('check_all_'.length);
    $('.check_box_' + group).prop('checked', $(this).prop('checked'));
	});
	
});
