var Modal = {
  modal: function(options) {
    return HandlebarsTemplates.modal(options);
  },

  methodGet: function(options) {
    return this.skeletonLayout(options);
  },

  methodOther: function(options) {
    return this.skeletonLayout(options);
  },

  skeletonLayout: function(options) {
    options.headers = this.headers();
    return HandlebarsTemplates['modal-layout'](options);
  },

  headers: function(prefix) {
    prefix = prefix || '';

    var defaultHeaders = {};
    if(typeof(Storage) !== "undefined") {
      //TODO use localStorage.get/set
      defaultHeaders = localStorage.getItem(defaultHeaders) || {};
    }

    var savedHeaders = {};
    if(typeof(Storage) !== "undefined") {
      //TODO napravi adpter funkciju za prefixiranje
      savedHeaders = localStorage.getItem(prefix + '_savedHeaders') || {};
    }

    var headers = [];
    $.each(
      $.extend(defaultHeaders, savedHeaders),
      function(key, value) {
        headers.push(
          {
            key: key,
            value: value || ''
          }
        );
      }
    );

    return HandlebarsTemplates.headers(headers);
  }
};
