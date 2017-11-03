var ChangePrivacy = {
    setup: function() {
        $('.prob_privacy').submit(function() {
            $.ajax({
                context: this,
                url: $(this).attr('action'),
                type: 'PUT',
                data: $(this).serialize(),
                success: function() {
                    var button = $(this).find('input[type="submit"]');

                    var newValue = button.attr('value');
                    if (newValue === "Public") {
                        newValue = "Share"
                    } else if (newValue === "Share") {
                        newValue = "Private"
                    } else {
                        newValue = "Public"
                    }
        
                    button.attr('value', newValue);
                    // $(this).find('input[name="privacy"]').attr('value', button.attr('value'));
                    debugger
                },
                error: function(thrownError) {
                    alert("Error: Privacy not updated to \"" + newValue + "\"");
                }
            });
            return false;
        });
    }
};
$(ChangePrivacy.setup);