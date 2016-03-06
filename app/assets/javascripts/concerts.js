// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var init_stock_lookup;
init_stock_lookup = function(){
  $('#stock-lookup-form').on('ajax:before',function(){
    show_spinner();
  });


}
