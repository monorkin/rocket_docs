//= require ./storage
//= require jquery
//= require jquery_ujs
//= require underscore
//= require handlebars.runtime
//= require_tree ./templates
//= require bootstrap
//= require ./http-headers
//= require ./modals-controller

$(document).ready(function() {
  var $body = $('body');
  var modalsController = new ModalsController();

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

   defaultHttpHeaders.attachHeaderListener(
     $httpHeadersCollapse.find('table.headers'),
     $httpHeadersCollapse.find('.add-header')
   );
});
