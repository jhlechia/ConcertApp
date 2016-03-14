// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require twitter/bootstrap
//= require turbolinks

//= require_tree .


var hide_spinner = function(){
  $('#spinner').hide();
}

var show_spinner = function(){
  $('#spinner').show();
}

var hide_flash = function(){
  $('div.alert').remove();
   console.log("Xxxxxxxxxxxxxxxxxxxxxxxxxx");
}



var hide_name = function(){
  $('#artist_name').val("");
}

var use_flash = function(){
  $('.top-div').append('<div class="alert fade in alert-info "><button type="button" class="close" data-dismiss="alert">×</button>Sorry, that artist doesn\'t have any events scheduled.</div>');
}

var use_flash_again = function(){
  $('.top-div').append('<div class="alert fade in alert-info "><button type="button" class="close" data-dismiss="alert">×</button>That is not a real artist, silly! Try again.</div>');
}
