$(document).on('page-change', function(){
  $( "tr onclick" ).hover(
    function() {
      $( this ).addClass( "hover" );
    }, function() {
      $( this ).removeClass( "hover" );
    }
  );
});
