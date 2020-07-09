$(document).on('turbolinks:load', function() {
  $(".js-remove").on("click", function(e) {
    var image_id = $(this).parent().attr('data-index')
    var pathname = location.pathname.slice( 0, -4 );
    var path = pathname + 'image_delete';
    
    $.ajax( {
      type: 'get',
      url: path,
      data: {image_id: image_id},
      dataType: 'json'
    })
    .done(function() {
      document.location.reload();
    });

  });
});