function initDropzone(){
  var dropzone, editor, editor_dropzone, self;
  self = this;
  editor = $("textarea.topic-editor");
  // editor.wrap("<div class=\"topic-editor-dropzone\"></div>");
  editor_dropzone = $('.topic-editor-dropzone');
  // alert(editor_dropzone)
  editor_dropzone.on('paste', (function(_this) {
    return function(event) {
      return self.handlePaste(event);
    };
  })(this));
  new Dropzone("div#topic-editor-dropzone", {
    url: "/photos",
    dictDefaultMessage: "",
    clickable: true,
    paramName: "file",
    maxFilesize: 20,
    uploadMultiple: false,
    previewTemplate: '<div style=\"display: none;\"></div>',
    headers: {
      "X-CSRF-Token": $("meta[name=\"csrf-token\"]").attr("content")
    },
    previewContainer: false,
    processing: function() {
      // $(".div-dropzone-alert").alert("close");
      return self.showUploading();
    },
    dragover: function() {
      editor.addClass("div-dropzone-focus");
    },
    dragleave: function() {
      editor.removeClass("div-dropzone-focus");
    },
    drop: function() {
      editor.removeClass("div-dropzone-focus");
      editor.focus();
    },
    success: function(header, res) {
      self.appendImageFromUpload([res.url]);
    },
    error: function(temp, msg) {
      alert(msg);
    },
    totaluploadprogress: function(num) {},
    sending: function() {},
    queuecomplete: function() {
      self.restoreUploaderStatus();
    }
  });
}

function uploadFile(item, filename) {
  var formData, self;
  self = this;
  formData = new FormData();
  formData.append("file", item, filename);
  return $.ajax({
    url: '/photos',
    type: "POST",
    data: formData,
    dataType: "JSON",
    processData: false,
    contentType: false,
    beforeSend: function() {
      return self.showUploading();
    },
    success: function(e, status, res) {
      self.appendImageFromUpload([res.responseJSON.url]);
      return self.restoreUploaderStatus();
    },
    error: function(res) {
      alert("上传失败");
      return self.restoreUploaderStatus();
    },
    complete: function() {
      return self.restoreUploaderStatus();
    }
  });
}
function handlePaste(e) {
  var image, pasteEvent, self;
  self = this;
  pasteEvent = e.originalEvent;
  if (pasteEvent.clipboardData && pasteEvent.clipboardData.items) {
    image = self.isImage(pasteEvent);
    if (image) {
      e.preventDefault();
      return self.uploadFile(image.getAsFile(), "image.png");
    }
  }
}
function isImage(data) {
  var i, item;
  i = 0;
  while (i < data.clipboardData.items.length) {
    item = data.clipboardData.items[i];
    if (item.type.indexOf("image") !== -1) {
      return item;
    }
    i++;
  }
  return false;
}

function showUploading() {
  $("#topic-upload-image").hide();
  if ($("#topic-upload-image").parent().find("span.loading").length === 0) {
    return $("#topic-upload-image").before("<span class='loading'><i class='fa fa-circle-o-notch fa-spin'></i></span>");
  }
}

function restoreUploaderStatus() {
  $("#topic-upload-image").parent().find("span.loading").remove();
  return $("#topic-upload-image").show();
}
function appendImageFromUpload(srcs) {
  var j, len, src, src_merged;
  src_merged = "";
  for (j = 0, len = srcs.length; j < len; j++) {
    src = srcs[j];
    src_merged = "![](" + src + ")\n";
  }
  this.insertString(src_merged);
  return false;
}

function edit_view(){
  $(".edit").addClass('active');
  $('.preview').removeClass('active');
  $('#preview').hide();
  $('#article_content').show();
  false
}

function preview_view(){
  $(".preview").addClass('active');
  $('.edit').removeClass('active');
  $('#preview').html('Loading...');
  $('#article_content').hide();
  $('#preview').show();
  $.post('/articles/preview', {body: $('#article_content').val()}, function(data){
    $('#preview').html(data.body);
  }).error(function() { alert("error"); });
  false
}

function pickupEmoji(){
  if(!window._emojiModal){
    window._emojiModal = new EmojiModalView()
    window._emojiModal.show()
  }else{
    window._emojiModal.show()
  }
}

function appendCodesFromHint(language){
  txtBox = $(".topic-editor")
  source = txtBox.val()
  var leng = source.length;
  prefix_break = ""
  if(txtBox.val().length > 0){
    prefix_break = "\n"
  }
  src_merged = prefix_break + "```"+ language +"\n\n```\n"
  before_text = source.slice(0, txtBox.prop("selectionStart"))
  after_text = source.slice(txtBox.prop("selectionStart"), leng)
  txtBox.val(before_text + src_merged + after_text)
  index = before_text.length + src_merged.length - 5
  txtBox.selectRange(index, index)
  txtBox.focus()
  txtBox.trigger('click')
}

function browseUpload(){
  $(".topic-editor").focus();
  $('.topic-editor-dropzone').click();
}