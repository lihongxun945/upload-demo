filedrop = (method, arg) ->
    $this = $ this
    $img = undefined
    createImage = (file) ->
        $img = $('<img />')
        reader = new FileReader()

        reader.onload = (e) ->
            $img.attr 'src', e.target.result

        reader.readAsDataURL file
        $this.empty()
        $img.appendTo $this

        createDrop = ->
            $crop = $img.Jcrop
                allowMove: true
                setSelect: [ 20, 20, 260, 190 ]
                aspectRatio: 26 / 19
                onSelect: (c)->
                    height = $img.height()
                    width = $img.width()
                    naturalHeight = $img.prop 'naturalHeight'
                    naturalWidth = $img.prop 'naturalWidth'
                    ratio = height / naturalHeight
                    $(".crop_x").val c.x/ratio
                    $(".crop_y").val c.y/ratio
                    $(".crop_w").val c.w/ratio
                    $(".crop_h").val c.h/ratio
        setTimeout(createDrop, 100)


    $this.on "dragover", (e)->
        e.preventDefault()
        e.stopPropagation()
    $this.on "drop", (e)->
        e.preventDefault()
        files = e.originalEvent.dataTransfer.files
        createImage(files[0])
    return $this

$.fn.extend
    croper:(method, arg) ->
        $(this).each ->
            filedrop.call(this, method, arg)

$(".file-drop").croper()
