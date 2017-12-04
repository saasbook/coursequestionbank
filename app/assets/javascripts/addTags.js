var AddTags = {
  setup: function() {
    $('.add_tags_form').submit(function() {
      $.ajax({
        context: this,
        url: $(this).attr('action'),
        type: 'POST',
        data: $(this).serialize(),
        success: function(data) {
          $(this).parent().find('.tag_list').html(data);
          RemoveTags.setup();
        }
      });
      $(this)[0].reset();
      return false;
    });
  }
};
$(AddTags.setup);

