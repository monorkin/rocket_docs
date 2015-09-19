(function() {
  function HttpHeaders(options) {
    this.storagePrefix = 'http_headers_';
    this.prefix = null;
    this.init(options);
  }

  HttpHeaders.prototype.init = function(options) {
    if (!options) {
      options = {};
    }

    this.prefix = this.storagePrefix + (options.prefix || '');
    if (this.prefix.charAt(this.prefix.length - 1) !== '_') {
      this.prefix += '_';
    }
  };

  HttpHeaders.prototype.headersTableHTML = function() {
    var defaultHeaders = Storage.get(this.storagePrefix + 'saved') || {};

    var savedHeaders = Storage.get(this.prefix + 'saved') || {};

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

    return HandlebarsTemplates.headers({
      headers: headers
    });
  };

  HttpHeaders.prototype.attachHeaderListener = function($headersTable, $addHeaderBtn) {
    var storeName = this.prefix + 'saved';

    $headersTable.on('keyup', '[contenteditable]', function() {
      var $this = $(this);
      var headers = Storage.get(storeName) || {};

      if ($this.data('type') === 'key') {
        var previousKeyName = $this.data('previous-value');
        var newKeyName = $this.text();
        var tempValue = headers[previousKeyName];

        if (previousKeyName) {
          delete(headers[previousKeyName]);

          headers[newKeyName] = tempValue;
          $this.data('previous-value', newKeyName);
        } else {
          headers[newKeyName] = tempValue;
          $this.data('previous-value', newKeyName);
        }
      } else if ($this.data('type') === 'value') {
        var $keyField = $this.data('key-field');
        if (!$keyField) {
          $keyField = $this.parent().find('[contenteditable][data-type="key"]');
          $this.data('key-field', $keyField);
        }

        var keyName = $keyField.data('previous-value');
        var previousValue = $this.data('previous-value');
        var newValue = $this.text();

        headers[keyName] = newValue;
        $this.data('previous-value', newValue);
      }

      Storage.set(storeName, headers);
    });

    $headersTable.on('click', '.delete-header', function() {
      var $this = $(this);
      var $row = $this.closest('tr');

      var keyName = $row.find('[data-type="key"]').data('previous-value');
      var headers = Storage.get(storeName) || {};

      $row.hide('fast', function() {
        $row.remove();
      });

      delete(headers[keyName]);

      Storage.set(storeName, headers);
    });

    $addHeaderBtn.on('click', function() {
      $headersTable.append(
        HandlebarsTemplates['header-row']()
      );
    });
  };

  var httpHeaders = [
    'Accept',
    'Accept-Charset',
    'Accept-Encoding',
    'Accept-Language',
    'Accept-Datetime',
    'Authorization',
    'Cache-Control',
    'Connection',
    'Cookie',
    'Content-Length',
    'Content-MD5',
    'Content-Type',
    'Date',
    'Expect',
    'From',
    'Host',
    'If-Match',
    'If-Modified-Since',
    'If-None-Match',
    'If-Range',
    'If-Unmodified-Since',
    'Max-Forwards',
    'Origin',
    'Pragma',
    'Proxy-Authorization',
    'Range',
    'Referer',
    'TE',
    'User-Agent',
    'Upgrade',
    'Via',
    'Warning'
  ];

  var nonStandardHttpHeaders = [
    'X-Requested-With',
    'DNT',
    'X-Forvarded-For',
    'X-Forwarded-Host',
    'X-Forwarded-Proto',
    'Front-End-Https',
    'X-Http-Method-Override',
    'X-ATT-DeviceId',
    'X-Wap-Profile',
    'Proxy-Connection',
    'X-UIDH',
    'X-Csrf-Token',
    'X-Api-Token'
  ];


  window.HttpHeaders = HttpHeaders;
})();
