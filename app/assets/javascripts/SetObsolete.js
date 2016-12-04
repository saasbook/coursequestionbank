var SetObsolete = {
    setup: function() {
        $('.prob_obsolete').submit(function() {
            $.ajax({
                url: $(this).attr('action'),
                type: 'PUT',
                data: $(this).serialize()
            });
            var button = $(this).find('input[type="submit"]');
            var field = $(this).find('input[name="obsolete"]');
            var obsolete = field.attr('value') === '1';
            field.attr('value', obsolete ? '0' : '1');
            button.attr('value', obsolete ? 'Obsolete' : 'Mark obsolete');
            return false;
        });
    }
};
$(SetObsolete.setup);
