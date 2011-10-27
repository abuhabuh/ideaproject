// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//


//= require jquery
//= require jquery_ujs
//= require_tree .

// faye chat client functionality
$(function() {
  var faye = new Faye.Client('http://localhost:9292/faye');

  if(document.getElementById("IDEA_CHAT_PAGE_FLAG")){
    var chat_id = document.getElementById("IDEA_CHAT_PAGE_FLAG").value
    // TODO: ensure you don't have to unsubscribe from channel
    //       specifications seem to say that this is not required
    faye.subscribe('/idea_chat/'+chat_id, function (data) {
      eval(data);
    });
  }
});
