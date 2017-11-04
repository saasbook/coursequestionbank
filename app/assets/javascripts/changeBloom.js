
var ChangeBloom = {
  setup: function() {
    $('.bloom-buttons').each(function() {
      var container = $(this);
      container.find('form').submit(function() {
        $.ajax({
          url: $(this).attr('action'),
          type: 'PUT',
          data: $(this).serialize()
        });

        var button = $(this).find('input[type="submit"]');
        var category = $(this).find('input[name="category"]').attr('value');

        // Reset all buttons to default action
        container.find('form').each(function() {
          var my_button = $(this).find('input[type="submit"]');
          var my_category_field = $(this).find('input[name="category"]');
          my_category_field.attr('value', my_button.attr('value'));
        });

        // Set 'none' action for current button if appropriate
        var category_field = $(this).find('input[name="category"]');
        if (category !== 'none')
          category_field.attr('value', 'none');

        // Stylize buttons based on action
        container.find('form').each(function() {
          var button = $(this).find('input[type="submit"]');
          var category = $(this).find('input[name="category"]').attr('value');
          button.removeClass('btn-default btn-info');
          if (category === 'none')
            button.addClass('btn-info');
          else
            button.addClass('btn-default');
        });

        return false;
      });
    });
  }
};
$(ChangeBloom.setup);