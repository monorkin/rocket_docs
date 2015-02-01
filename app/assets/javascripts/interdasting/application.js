//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require interdasting/prettify/prettify

$(document).ready(function () {
  $('#try-out-modal').on('show.bs.modal', function (event) {
    var $modal = $(this);
    var $triggerButton = $(event.relatedTarget);
    var $testButton = $modal.find('.btn.try');
    $modal.find('h4.modal-title').text('' +
      $triggerButton.data('request-method') + ' ' + $triggerButton.data('url')
    );
    $modal.find('.modal-body').html(
      contentForModal(
        $triggerButton.data('url'),
        $triggerButton.data('request-method'),
        $triggerButton.data('params'),
        $triggerButton.data('saved_params'),
        $triggerButton.data('saved_text')
      )
    );
    $testButton.click(function(){
      var $response = $modal.find('pre.response')
      $modal.find('.response-body').removeClass('hidden');
      addSpinner($response);
    });
      prettyPrint();
  }).on('hidden.bs.modal', function (e) {
    var $modal = $(this);
    $modal.find('h4.modal-title').text('Try it');
    $modal.find('.modal-body').html('');
  })

  function addSpinner($object) {
      var message = '<center>'+
                      '<span class="glyphicon glyphicon-refresh gly-spin"></span>'+
                      '  Waiting for response...'+
                    '</center>';
      var longMessage = '<center>'+
                          '<span class="glyphicon glyphicon-refresh gly-spin"></span>'+
                          '  Ok... This is taking too long!'+
                        '</center>';
      $object.removeClass('prettyprinted');
      $object.html(message);
      setTimeout(function(){
        if ($object.html() === message) $object.html(longMessage);
        }, 2000);
  }

  function contentForModal(url, method, params, savedParams, savedText) {
    var content = ''
    content += '<h3>Request body</h3>'
    if (method === 'GET' && params) {
      content += '<table class="table table-striped">';
      content += '<thead>';
      content += '<tr>'+
                   '<th>Param</th>'+
                   '<th>Value</th>'+
                 '</tr>';
      content += '</thead>';
      $.each(params, function(k, _v) {
        var saved = '';
        if (savedParams) saved = savedParams[key];
        content += '<tr>'+
                     '<td>' + k + '</td>'+
                     '<td><input type="text" class="form-control" value="' + saved + '" data-key="' + k + '"></td>'+
                   '</tr>';
      });
      content += '</table>';
    } else {
      var saved = ''
      if (savedText) saved = savedText;
      content += '<textarea class="form-control" rows="6" cols="90">' + saved + '</textarea>';
    }
    if (method !== 'GET' && params) {
      content += '<h4>Expected params</h4>'
      content += '<table class="table table-striped">';
      content += '<thead>';
      content += '<tr>'+
                   '<th>Name</th>'+
                   '<th>Type</th>'+
                 '</tr>';
      content += '</thead>';
      $.each(params, function(k, v) {
        var saved = '';
        if (savedParams) saved = savedParams[key];
        content += '<tr>'+
                     '<td>' + k + '</td>'+
                     '<td>' + v + '</td>'+
                   '</tr>';
      });
      content += '</table>';
    }
    content += '<div class="response-body hidden">'
    content += '<hr>';
    content += '<h3>Response</h3>'
    content += '<pre class="response prettyprint"></pre>'
    content += '</div>'

    return content;
  }
});
