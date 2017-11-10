var MinorUpdate = {
    setup: function() {
        $('.minor_form form').submit(function(e) {
            $.ajax({
                url: $(this).attr('action'),
                context: this,
                type: 'POST',
                data: $(this).serialize(),
                success: function(data, textStatus, jqXHR) {
                    if (data.error === null)
                        window.location.reload();
                    else
                        $(this).find('.message').text(data.error);
                }
            });
            return false;
        });
    }
};
$(MinorUpdate.setup);