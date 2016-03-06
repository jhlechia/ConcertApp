$(document).on('page-change', function(){
  $( "tr" ).hover(
    function() {
      $( this ).addClass( "hover" );
    }, function() {
      $( this ).removeClass( "hover" );
    }
  );
});
