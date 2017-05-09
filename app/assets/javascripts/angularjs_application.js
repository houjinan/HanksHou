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

//= require angular
//= require angular-route
//= require angular-resource
//= require plugins/angular-ui-router
//= require angular-rails-templates

//= require angularjs/app
//= require angularjs/ext_resource


//= require_tree ./angularjs/controllers
//= require_tree ./angularjs/services
//= require_tree ./angularjs/templates
//= require_tree ./angularjs/directives
//= require_tree ./angularjs/filters



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