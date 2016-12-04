var ChangeCollections = {
  setup: function() {
    $('.collection-buttons').each(function() {
      var container = $(this);
      container.find('form').submit(function() {
        $.ajax({
          url: $(this).attr('action'),
          type: 'PUT',
          data: $(this).serialize()
        });

        var button = $(this).find('input[type="submit"]');

        if (button.hasClass('btn-info')) {
          button.removeClass('btn-info');
          button.addClass('btn-default');
        }
        else if (button.hasClass('btn-default')) {
          button.removeClass('btn-default');
          button.addClass('btn-info');
        }

        return false;
      });
    });
  }
};
$(ChangeCollections.setup);