var ready = function() {
  $(".button-collapse").sideNav();
  $('select').material_select();  
  $('#review_text').trigger('autoresize');
  $('#new_review').bind('submit', function (event) {
    event.preventDefault();
    event.stopImmediatePropagation();
    var form = $(this);
    $.ajax({
      url: form.attr('action'),
      method: form.attr('method'),
      data: form.serialize(),
      success: function (json) {
        var divider = $("<div></div>", { class: "divider" });
        var user_link = '<small><a href="' + json['user_profile_url'] + '">- ' + json["user"] + "</a></small>";
        $('#reviews-section')
          .append(divider, '<div class="section">' +
            '<p>' + json['text'] + '</p>' +
            '<p>' + json['rating_out_of_ten'] + '/10</p>' + user_link + '<br>' + '</div>')
      }
    });
    $("#review_text").val("");
    $("#review_rating_out_of_ten").val("");
  });   
    $('#new_movie').bind('submit', function (event) {
    event.preventDefault();
    event.stopImmediatePropagation();
    var form = $(this);
    var formData = new FormData($(this)[0]);
    $.ajax({
      url: form.attr('action'),
      method: form.attr('method'),
      data: formData,
      success: function (json) {
        var divider = $("<div></div>", { class: "divider" });
        var img_thumb = '<a href="'+ json['page_url'] +'" ><img src="' + json['img_thumb_url'] + '" /></a>';
        var title = '<a href="'+ json['page_url'] +'" >' + json['title'] + '</a>';
          if (json["avg_rating"] == null) {
            avg_rating = '<p></p>';
          } else {
            rating_value = json['avg_rating'];
            avg_rating = '<p>Average rating: '+ rating_value + '</p>';
          };
        $('#movies-section')
          .prepend(divider, '<div class="section">' + '<div class="row">' +
            '<div class="col s4">' + img_thumb + '</div>' + '<div class="col s8">' +
            '<h5>' + title + '</h5>' + '<p>' + json["release_date"] + '</p>' + 
            '<p>' + json["director"] + '</p>' + '<p>' + json["desc"] + '</p>' + avg_rating + '</div></div></div>')
        },
        processData: false,
        contentType: false,
        cache: false
      });
  });
}

$(document).ready(ready);
$(document).on('page:change',ready);