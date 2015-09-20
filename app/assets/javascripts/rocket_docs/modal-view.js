var ModalView = {
  modal: function(options) {
    return HandlebarsTemplates.modal(options);
  },

  layout: function(options) {
    options.params = this.paramsList(options.params || {});
    options.urlParams = this.urlParamsList(options.url);
    return HandlebarsTemplates['modal-layout'](options);
  },

  urlParamsList: function(url) {
    var params = this.urlParams(url);

    if (!params) return;

    return HandlebarsTemplates['url-params-list']({
      params: params
    });
  },

  urlParams: function(url) {
    var params = url.match(/\{[^\}]+\}/gi);

    if (!params || params.length === 0) return;

    var cleanParams = [];

    $.each(params, function (i, param) {
      cleanParams.push(
        {
          key: param.substring(1, param.length - 1)
        }
      );
    });

    return cleanParams;
  },

  paramsList: function(params) {
    if (Object.keys(params).length === 0) return null;

    var structuredParams = this.buildStructuredParams(params);

    return HandlebarsTemplates['params-list']({
      params: structuredParams
    });
  },

  buildStructuredParams: function(params) {
    if (Object.keys(params).length === 0) return null;

    structuredParams = [];

    $.each(params, function(key, value) {
      if (typeof(value) !== 'object') {
        structuredParams.push(
          {
            key: key,
            type: value
          }
        );
      } else {
        ModalView.expandStructuredParams(structuredParams, value, key);
      }
    });

    return structuredParams;
  },

  expandStructuredParams: function(structuredParams, params, name) {
    if (Object.keys(params).length === 0) return;

    $.each(params, function(key, value) {
      if (typeof(value) !== 'object') {
        structuredParams.push(
          {
            key: name + '[' + key + ']',
            type: value
          }
        );
      } else {
        ModalView.expandStructuredParams(
          structuredParams,
          value,
          name + '[' + key + ']'
        );
      }
    });
  }
};
