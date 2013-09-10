function requestIsProcessing(){
  $('#messages').html("<p>Processing your request</p>");
  $('input').prop('disabled', true);
}

function requestIsDone(){
  $('#messages').html("<p>Request Successful!</p>");
  $('input').prop('disabled', false);
}

$( document ).ajaxStart(function() {
  requestIsProcessing();
  $('#spinner').toggle();
});

$( document ).ajaxStop(function() {
  requestIsDone();
  $('#spinner').toggle();
});


$(document).ready(function() {
  $('#get_tweets').on('submit', function(e){
    e.preventDefault();
    var params = $(this).serialize();

    $.ajax({
      type: "GET",
      url:"/",
      data: params
    }).done(function(server_response){
      $('#recent_tweets').html(server_response);
    }).fail(function(){console.log('get tweets fail');
    });

  });

  $('#send_tweet').on('submit', function(e){
    e.preventDefault();
    var params = $(this).serialize();

    $.ajax({
      type: this.method,
      url: this.action,
      data: params
    }).done(function(){
      requestIsDone();
      $('#send_tweet input[type=text]').val('');
    }).fail(function(){console.log('send tweet fail');
    });

  });

});
