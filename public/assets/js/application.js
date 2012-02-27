var fetch_tracks = function (json_params) {
  $.getJSON("/get_tracks.json",  
    json_params,  
    function(data) {  
      $('#fetching-tracks').hide()

      if(!data["error"]) {
        $('#select-target').show()
      } else {
        $('#the-error').html(data["error"])
        $('#error-msg').show()
      }
    }  
  );

  $('#select-source').hide()
  $('#fetching-tracks').show()      
}

$('#lastfm-loved-source').on('shown', function () {
  $('#lastfm-loved-username').focus()
})

$('#lastfm-7day-source').on('shown', function () {
  $('#lastfm-7day-username').focus()
})

$('#hypem-loved-source').on('shown', function () {
  $('#hypem-loved-username').focus()
})

$('#lastfm-loved-save').on('click', function () {
  fetch_tracks({"lastfm-loved-username": $('#lastfm-loved-username').val()})
})

$('#lastfm-7day-save').on('click', function () {
  fetch_tracks({"lastfm-7day-username": $('#lastfm-7day-username').val()})
})

$('#rdio-target').on('shown', function () {
  $('#rdio-target-ok').focus()
})

// TODO not sure how to execute this code only on the right page. this will do
$(document).ready(function () {
  if($('#working-on-it').is(':visible')) {
    $.getJSON("/add_to_playlist.json",  
      function(data) {  
        $('#working-on-it').hide()

        if(data["complete"] == "true") {
          $('#masthead').hide()
          $('#done').show()
        } else {
          $('#the-error').html(data["error"])
          $('#error-msg').show()
        }
      }  
    );    
  }
});

$('#rdio-target-ok').on('click', function () {
  window.location.replace("/auth/rdio");
})