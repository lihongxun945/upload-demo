// Generated by CoffeeScript 1.6.3
(function() {
  var filedrop;

  filedrop = function(method, arg) {
    var $img, $this, createImage;
    $this = $(this);
    $img = void 0;
    createImage = function(file) {
      var createDrop, reader;
      $img = $('<img />');
      reader = new FileReader();
      reader.onload = function(e) {
        return $img.attr('src', e.target.result);
      };
      reader.readAsDataURL(file);
      $this.empty();
      $img.appendTo($this);
      createDrop = function() {
        var $crop;
        return $crop = $img.Jcrop({
          allowMove: true,
          setSelect: [20, 20, 260, 190],
          aspectRatio: 26 / 19,
          onSelect: function(c) {
            var height, naturalHeight, naturalWidth, ratio, width;
            height = $img.height();
            width = $img.width();
            naturalHeight = $img.prop('naturalHeight');
            naturalWidth = $img.prop('naturalWidth');
            ratio = height / naturalHeight;
            $(".crop_x").val(c.x / ratio);
            $(".crop_y").val(c.y / ratio);
            $(".crop_w").val(c.w / ratio);
            return $(".crop_h").val(c.h / ratio);
          }
        });
      };
      return setTimeout(createDrop, 100);
    };
    $this.on("dragover", function(e) {
      e.preventDefault();
      return e.stopPropagation();
    });
    $this.on("drop", function(e) {
      var files;
      e.preventDefault();
      files = e.originalEvent.dataTransfer.files;
      return createImage(files[0]);
    });
    return $this;
  };

  $.fn.extend({
    croper: function(method, arg) {
      return $(this).each(function() {
        return filedrop.call(this, method, arg);
      });
    }
  });

  $(".file-drop").croper();

}).call(this);
