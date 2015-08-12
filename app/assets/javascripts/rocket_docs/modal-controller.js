//= require ./modal
//= require ./animated-modal

function ModalControler(options) {
  this.method = null;
  this.params = null;
  this.url = null;
  this.storePrefix = null;
  this.headers = null;
  this.init(options);
}

ModalControler.prototype.init = function(options) {
  this.method = options.method || 'GET';
  this.params = options.params || {};
  this.url = options.url || '';
  this.storePrefix = options.storePrefix || '';
  this.headers = new HttpHeaders({
    prefix: this.storePrefix
  });
};

ModalControler.prototype.show = function(options) {
  options = options || {};
  options.klass = options.klass || '';

  this.$modal = this.$modal || $('.animatedModal' + options.klass);

  if (this.$modal.length === 0) {
    this.appendModal({
      klass: 'method-' + this.method.toLowerCase(),
      content: this.viewForData()
    });
  }

  this.attachHeaderListener();
  this.$modal.animatedModal('show', options);
};

ModalControler.prototype.hide = function() {
  if (!this.$modal) return;

  this.$modal.animatedModal('hide');
};

ModalControler.prototype.appendModal = function(options) {
  this.$modal = $(Modal.modal(options));
  $('body').append(this.$modal);
};

ModalControler.prototype.viewForData = function() {
  if (this.method.toLowerCase() === 'get') {
    return Modal.methodGet(
      {
        headers: this.headers.headersTableHTML(),
        url: this.url,
        params: this.params,
        responsePreview: this.responsePreview
      }
    );
  }
  return Modal.methodOther(
    {
      klass: 'method-' + this.method.toLowerCase(),
      headers: this.headers.headersTableHTML(),
      url: this.url,
      params: this.params,
      responsePreview: this.responsePreview
    }
  );
};

ModalControler.prototype.attachHeaderListener = function() {
  if (!this.$modal) return;

  $headersTable = this.$headersTable = this.$headersTable || this.$modal.find('table.headers');
  $addHeaderBtn = this.$addHeaderBtn = this.$addHeaderBtn || this.$modal.find('button.add-header');

  this.headers.attachHeaderListener($headersTable, $addHeaderBtn);
};
