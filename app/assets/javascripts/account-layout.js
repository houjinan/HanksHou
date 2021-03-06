//= require jquery2
//= require jquery_ujs
//= require bootstrap.min
//= require jquery-fileupload/basic
//= require turbolinks
//= require react
//= require react_ujs
//= require components


//= require jquery.fluidbox.min
//= require dropzone
//= require underscore
//= require backbone
//= require emoji-data
//= require emoji-modal
//= require jquery.autogrow-textarea
//= require form_storage
//= require article_markdown
//= require cropper.min
//= require upload-crop-pic
//= require d3.min
//= require cal-heatmap

function choice_label(label){
  var has_labels = $("#labels").val().split(",");
  if($("#labels").val().length == 0){
    $("#labels").val(label);
  }else{
    if(has_labels.indexOf(label) < 0){
      $("#labels").val($("#labels").val() + "," + label);
    }
  }
}


function insertString(str){
  $target = $(".topic-editor")
  start = $target[0].selectionStart
  end = $target[0].selectionEnd
  $target.val($target.val().substring(0, start) + str + $target.val().substring(end));
  $target[0].selectionStart = $target[0].selectionEnd = start + str.length
  $target.focus()
}

$.fn.selectRange = function(start, end) {
  if(end === undefined) {
      end = start;
  }
  return this.each(function() {
    if('selectionStart' in this) {
        this.selectionStart = start;
        this.selectionEnd = end;
    } else if(this.setSelectionRange) {
        this.setSelectionRange(start, end);
    } else if(this.createTextRange) {
        var range = this.createTextRange();
        range.collapse(true);
        range.moveEnd('character', end);
        range.moveStart('character', start);
        range.select();
    }
  });
};
