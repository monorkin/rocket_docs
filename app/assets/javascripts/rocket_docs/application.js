//= require ./storage
//= require jquery
//= require jquery_ujs
//= require underscore
//= require handlebars.runtime
//= require_tree ./templates
//= require bootstrap
//= require ./http-headers
//= require ./modal-controller

$(document).ready(function() {
  $('[data-toggle="animated-modal"]').on('click', function() {
    var $this = $(this);
    if (!$this.data('modal')) {
      var options = {
        method: $this.data('request-method'),
        params: $this.data('params'),
        url: $this.data('url'),
        storePrefix: $this.data('store-prefix')
      };

      var modal = new ModalControler(options);
      $this.data('modal', modal);
    }

    $this.data('modal').show();
  });
});
