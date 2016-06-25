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
}

$(document).ready(ready);
$(document).on('page:change',ready);