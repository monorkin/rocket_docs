//= require ./modal

function ModalsController() {
  this.init();
}

ModalsController.prototype.init = function () {
  $('[data-toggle="animated-modal"]').on('click', function() {
    var $this = $(this);

    if (!$this.data('modal')) {
      var options = {
        method: $this.data('request-method'),
        params: $this.data('params'),
        url: $this.data('url'),
        storePrefix: $this.data('store-prefix')
      };

      var modal = new Modal(options);
      $this.data('modal', modal);
    }

    $this.data('modal').show();
  });
};
