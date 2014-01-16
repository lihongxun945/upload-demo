filedrop = (method, arg) ->
    $this = $ this
    $area = $this.find(".area")
    $img = undefined
    formData = undefined
    SIZE = [520, 380]
    selectedArea = undefined
    createImage = (file) ->
        $img = $('<img />')
        reader = new FileReader()

        reader.onload = (e) ->
            $img.attr 'src', e.target.result

        reader.readAsDataURL file
        $area.empty()
        $img.appendTo $area

        createDrop = ->
            height = $img.height()
            width = $img.width()
            naturalHeight = $img.prop 'naturalHeight'
            naturalWidth = $img.prop 'naturalWidth'
            ratio = height / naturalHeight
            if not (naturalWidth> SIZE[0]) or not (naturalHeight>SIZE[1])
                $img.replaceWith("<span>图片大小必须大于"+SIZE[0]+"*"+SIZE[1]+"</span>")
                return
            select = [0, 0, SIZE[0]*ratio, SIZE[1]*ratio]
            select[0] = (width - select[2]) / 2
            select[1] = (height- select[3]) / 2
            select[2] = select[0] + select[2]
            select[3] = select[1] + select[3]

            $crop = $img.Jcrop
                allowMove: true
                allowResize: false
                setSelect: select
                onSelect: (c)->
                    selectedArea =
                        x: Math.round c.x/ratio
                        y: Math.round c.y/ratio
                        width: SIZE[0]
                        height: SIZE[1]
                    $this.find(".crop-x").html selectedArea.x
                    $this.find(".crop-y").html selectedArea.y
                    $this.find(".crop-w").html selectedArea.width
                    $this.find(".crop-h").html selectedArea.height

        setTimeout(createDrop, 100)

    submit = ->
        formData.append('x-gmkerl-crop', JSON.stringify(selectedArea))
        formData.append('x-gmkerl-thumbnail', 'your-thumbnail-name')
        formData.append('x-gmkerl-type', JSON.stringify({fix_scale: 50}))
        $.ajax
            url: $this.data("url")
            data: formData
            processData: false
            contentType: false
            type: 'POST'
            success: (data) ->
                alert(data)



    $area.on "dragover", (e)->
        e.preventDefault()
        e.stopPropagation()
    $area.on "drop", (e)->
        e.preventDefault()
        files = e.originalEvent.dataTransfer.files
        createImage(files[0])
        formData = new FormData()
        formData.append("files", files[0])
    $this.find(".submit").click submit

    return $this

$.fn.extend
    croper:(method, arg) ->
        $(this).each ->
            filedrop.call(this, method, arg)

$(".file-drop").croper()
