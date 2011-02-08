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

  $('.upload').fileUploadUI({
    uploadTable: $('.upload_files'),
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
    }
  });
  
  var client = new Faye.Client('/faye');
  client.subscribe('/files', function(f) {
    var link = $('<a />').html(f.name).attr({href: f.data, target: '_blank'});
    var size = $('<span />').css('float', 'right').html((Math.round(f.size / 102.4) / 10) + "kB");
    var info = $('<div />').html(new Date().toLocaleString());
    $('<li />').append(link).append(size).append(info).prependTo('.arrivals ul');
  });
});