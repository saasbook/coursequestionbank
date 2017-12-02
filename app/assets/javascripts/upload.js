function upload_handling() {
  //var intervalId = setInterval(poll, 5000);
  setTimeout(poll, 3000);
  function poll() {
      $.ajax({
        type: "GET",
        timeout: 5000,
        async: false,
        url: "/upload/fetch",
        success: function(data) {
          //alert("File Upload was successful!")
          if (data == 1) {
            alert("File Uploaded Successfully!");
          } else {
            setTimeout(poll, 3000);
          }
        },
        error: function (jqXHR, textStatus, errorMessage) {
          console.log(errorMessage);
          //alert(errorMessage)
          //clearInterval(intervalId);
          /*$.ajax({
            type: "POST",
            async: false,
            url: "/upload/redirectSuccess/1"
          });*/
        }
    });
  };
}    