function HttpHeaders(options) {
  this.storagePrefix = 'http_headers_';
  this.prefix = null;
  this.init(options);
}

HttpHeaders.prototype.init = function(options) {
  this.prefix = this.storagePrefix + (options.prefix || '');
  if (this.prefix.charAt(this.prefix.length - 1) !== '_') {
    this.prefix += '_';
  }
};

HttpHeaders.prototype.headersTableHTML = function() {
  var defaultHeaders = {};
  if(typeof(Storage) !== "undefined") {
    //TODO use localStorage.get/set
    defaultHeaders = Storage.get(this.prefix + 'default') || {};
  }

  var savedHeaders = {};
  if(typeof(Storage) !== "undefined") {
    savedHeaders = Storage.get(this.prefix + 'saved') || {};
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
};

HttpHeaders.prototype.attachHeaderListener = function($headersTable, $addHeaderBtn) {
  $headersTable.on('change', '[data-key]', function() {
    console.log('A');
  });

  $addHeaderBtn.on('click', function() {
    console.log('B');
    $headersTable.append(
      HandlebarsTemplates['header-row']()
    );
  });
};
