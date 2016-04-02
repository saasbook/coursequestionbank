
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


var RemoveTags = {
  setup: function() {
    $('.remove_tag').submit(function() {
      $(this).parent().remove();
      $.ajax({
        url: $(this).attr('action'),
        type: 'POST',
        data: $(this).serialize()
      });
      return false;
    });
  }
};
$(RemoveTags.setup);


var ChangePrivacy = {
  setup: function() {
    $('.prob_privacy form').submit(function() {
      var button = $(this).find('input[type="submit"]');
      button.attr('value', button.attr('value') == 'Public' ? 'Private' : 'Public');
      $.ajax({
        url: $(this).attr('action'),
        type: 'POST',
        data: $(this).serialize()
      });
      return false;
    });
  }
};
$(ChangePrivacy.setup);


var ChangeBloom = {
  setup: function() {
    $('.bloom-buttons').each(function() {
      var container = $(this);
      container.find('form').submit(function() {
        
        var this_button = $(this).find('input[type="submit"]');
        container.find('form input[type="submit"]').each(function() {
          $(this).removeClass('btn-default btn-info');
          if ($(this).is(this_button))
            $(this).addClass('btn-info');
          else
            $(this).addClass('btn-default');
        });
        
        $.ajax({
          url: $(this).attr('action'),
          type: 'POST',
          data: $(this).serialize()
        });
        return false;
      });
    });
  }
};
$(ChangeBloom.setup);
