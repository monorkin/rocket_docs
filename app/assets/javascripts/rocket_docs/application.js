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
  var $body = $('body');

  /*
   * Render HTTP-Header editor
   */
   var defaultHttpHeaders = $body.data('http-headers');
   if (!defaultHttpHeaders) {
     defaultHttpHeaders = new HttpHeaders();
     $body.data('http-headers', defaultHttpHeaders);
   }

   var httpHeadersCollapseHtml = HandlebarsTemplates.collapse({
     groupId: 'rocket_docs_http_headers_editor_group',
     id: 'rocket_docs_http_headers_editor',
     title: 'Default HTTP Headers',
     content: defaultHttpHeaders.headersTableHTML()
   });

   var $httpHeadersCollapse = $(httpHeadersCollapseHtml);

   $body.find('#rocket_docs_documentation_description_group').after(
     $httpHeadersCollapse
   );

  /*
   * Toggle try-out-modal
   */
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
