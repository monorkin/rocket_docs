var Storage = {
  storageAdapter: null,

  localStorageAvailable: function() {
    var test = 'test';
    try {
      localStorage.setItem(test, test);
      localStorage.removeItem(test);
      return true;
    } catch(e) {
      return false;
    }
  },

  storage: function() {
    if (!this.storageAdapter) {
      if (this.localStorageAvailable()) {
        this.storageAdapter = localStorage;
      } else {
        this.storageAdapter = {};
        console.log('RocketDocs: LocalStorage is not available!');
      }
    }

    if (this.storageAdapter === localStorage) {
      if (!this.localStorageAvailable()) {
        console.log('RocketDocs: LocalStorage is full!');
        localStorage.clear();
        console.log('RocketDocs: LocalStorage cleared.');
      }
    }

    return this.storageAdapter;
  },

  get: function(key) {
    var store = this.storage();
    if (store === localStorage) {
      return store.getItem(key);
    } else {
      return store[key];
    }
  },

  set: function(key, value) {
    if (!key || !value) {
      return null;
    }

    if (store === localStorage) {
      store.setItem(key, value);
    } else {
      store[key] = value;
    }
    return value;
  }
};
