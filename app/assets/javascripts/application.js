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

jQuery(document).ready(function() {

	$('.maintable').find('.answers').hide(); //Hide/close all containers
    $('.maintable').find('.additional').hide();
    $('.text').addClass('toggler').removeClass('text');
    $('.maintable').find('.toggler').addClass('text').removeClass('toggler');
	$('.icon').click(function(){
	
		$('#q' + $(this).attr('id')).find('.answers').toggle();
		$('#q' + $(this).attr('id')).find('.additional').toggle();
		$('#q' + $(this).attr('id')).find('.text, .toggler').toggleClass("text toggler");
		$('#q' + $(this).attr('id')).find('.colname, .toggler2').toggleClass("colname toggler2");		
		$('.icon').toggleClass("glyphicon glyphicon-chevron-right icon glyphicon glyphicon-chevron-down icon")
	});
});

