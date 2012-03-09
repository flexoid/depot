function comment_show_reply_form(comment_id) {
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