
var Supersession = {
  setup: function() {
    $('.supersede_button').click(function() {
      $(this).parent().children('.supersede_form').toggle();
      return false;
    });
    
    $('.supersede_form form').submit(function(e) {
      $.ajax({
          context: this,
          url: $(this).attr('action'),
          type: 'POST',
          data: $(this).serialize(),
          success: function(data, textStatus, jqXHR) {
            if (data.error == null)
              window.location.href = '/problems';
            else
              $(this).children('.message').text(data.error);
          }
      });
      return false;
    });
  }
};

$(Supersession.setup)
