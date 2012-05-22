function comment_show_reply_form(comment_id) {
  $('.comment .reply a').show();
  var form = $('#comments_form');
  $('input[name="comment[parent_id]"]',form).val(comment_id);
  if(comment_id) {
    var reply = $('#comment-'+comment_id+' > .reply');
    $('a',reply).hide();
  }
  else {
    var reply = $('#add_comment');
  }
  reply.append(form);
  form.show();
  $('#comment_text', form).focus();
  return false;
}


function highlight_comment(comment_id) {
  $('#comment-' + comment_id).effect("highlight", {}, 3000);
}

function scroll_to_comment(comment_id) {
  $('html,body').animate({scrollTop: $('#comment-' + comment_id).offset().top},'slow');
}
