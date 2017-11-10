var SetObsolete = {
    setup: function() {
        $('.prob_obsolete').submit(function() {
            var button = $(this).find('input[type="submit"]');
            var field = $(this).find('input[name="obsolete"]');
            var obsolete = field.attr('value') === '1';
            $.ajax({
                context: this,
                url: $(this).attr('action'),
                type: 'PUT',
                data: $(this).serialize(),
                success: function() {
                    field.attr('value', obsolete ? '0' : '1');
                    button.attr('value', obsolete ? 'Obsolete' : 'Mark obsolete');
                },
                error: function() {
                    if (obsolete) {alert("Error: Question not updated to \"Obsolete\"");}
                    else {alert("Error: Question not updated to Mark \"Obsolete\"");}
                }
            });
            return false;
        });
    }
};
$(SetObsolete.setup);
