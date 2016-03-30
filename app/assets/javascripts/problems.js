
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

$(Supersession.setup);


var AddTags = {
  setup: function() {
    $('.problem_row').each(function() {
      var problem_row = $(this);
      var problem_id = problem_row.attr('id').substring(1);
      var add_tags_form = problem_row.find('.add_tags_form');
      
      add_tags_form.submit(function() {
        $.ajax({
          url: '/problems/' + problem_id + '/tags/add',
          type: 'POST',
          data: $(this).serialize(),
          success: function(data, textStatus, jqXHR) {
            problem_row.find('.tag_list').html(data);
          }
        });
        add_tags_form[0].reset();
        return false;
      });
    });
  }
};

$(AddTags.setup);
