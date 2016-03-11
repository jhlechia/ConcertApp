// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var init_concert_lookup;
init_concert_lookup = function(){
  $('#concert-lookup-form').on('ajax:before',function(){
    show_spinner();
  $('#concert-lookup-results').empty();
  });
}

$(document).on('ready page:load', function() {
  init_concert_lookup();
});

// $(document).ready(function(){
// })
