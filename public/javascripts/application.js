$(function(){
  window.Upload = Backbone.Model.extend({
    EMPTY: "New file...",
    initialize: function() {
      if (!this.get("filename")) {
        this.set({ "filename": this.EMPTY });
      }
    },
    
    clear: function() {
      this.destroy();
      this.view.remove();
    }
  });
  
  window.FileList = Backbone.Collection.extend({
    model: File
  });
  
  window.FileListView = Backbone.View.extend({
    events: {
      
    }
  });
  
  $(function () {
    $('.upload').fileUploadUI({
        uploadTable: $('.upload_files'),
        downloadTable: $('.download_files'),
        buildUploadRow: function (files, index) {
            var file = files[index];
            return $(
                '<tr>' +
                '<td>' + file.name + '<\/td>' +
                '<td class="file_upload_progress"><div><\/div><\/td>' +
                '<td class="file_upload_cancel">' +
                '<div class="ui-state-default ui-corner-all ui-state-hover" title="Cancel">' +
                '<span class="ui-icon ui-icon-cancel">Cancel<\/span>' +
                '<\/div>' +
                '<\/td>' +
                '<\/tr>'
            );
        },
        buildDownloadRow: function (file) {
            return $(
                '<tr><td>' + file.name + '<\/td><\/tr>'
            );
        }
    });
  });
});