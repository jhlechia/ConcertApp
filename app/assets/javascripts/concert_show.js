// $(document).on('page-change', function(){
//   $('tr[data-link]').click(function(){
//     window.location = this.dataset.link;
//   });
// });

$(document).on('page-change', function(){
  $('tr[data-link]').click(function(){
    window.location = this.data("link");
  });
});
