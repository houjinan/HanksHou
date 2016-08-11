(function() {
  this.FormStorage = {
    key: function(element) {
      return location.pathname + " " + ($(element).prop('id'));
    },
    init: function() {
      if (window.localStorage) {
        $(document).on('input', 'textarea', function() {
          var textarea;
          textarea = $(this);
          return localStorage.setItem(FormStorage.key(textarea), textarea.val());
        });
        $(document).on('submit', 'form', function() {
          var form;
          form = $(this);
          return form.find('textarea').each(function() {
            return localStorage.removeItem(FormStorage.key(this));
          });
        });
        return $(document).on('click', 'form a.reset', function() {
          var form;
          form = $(this).closest('form');
          return form.find('textarea').each(function() {
            return localStorage.removeItem(FormStorage.key(this));
          });
        });
      }
    },
    restore: function() {
      if (window.localStorage) {
        return $('textarea').each(function() {
          var textarea, value;
          textarea = $(this);
          if (value = localStorage.getItem(FormStorage.key(textarea))) {
            return textarea.val(value);
          }
        });
      }
    }
  };

}).call(this);
