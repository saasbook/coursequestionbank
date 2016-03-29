
var Supersession = {
  setup: function() {
    $('.supersede_button').click(function() {
      $(this).parent().children('.supersede_form').toggle();
      return false;
    });
  }
};

$(Supersession.setup)
