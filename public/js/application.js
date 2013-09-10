function toggleSpinner(){
  $('#spinner').toggle();
}

$( document ).ajaxStart(function() {
  toggleSpinner();
});

$( document ).ajaxStop(function() {
  toggleSpinner();
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
    }).fail(function(){console.log('wah wah');
  });
});
});
