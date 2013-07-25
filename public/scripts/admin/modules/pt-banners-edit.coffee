ptBannersEdit = angular.module "ptBannersEdit", ["ngResource"]
  
ptBannersEdit.directive "ptBannersEdit", ->
  link: (scope, element, attrs) ->
    element.sortable()
    
    scope.getRange = ->
      range = {}
      element.children().each (position, banner) ->
        id = $(banner).attr "pt-banner-id"
        range[id] = position if id
      range

ptBannersEdit.directive "ptBannerEdit", (CKEditor, $timeout) ->
  link: (scope, element, attrs) ->
    lastValue =
      image: {}
      gallery: []
      html: " "
      flash: " "

    upload = (width, height, callback) ->
      fileupload = $("<input type=\"file\">").fileupload
        url: "/uploads?width=#{width}&height=#{height}&action=resize"
        paramName: "file"
        previewCrop: true
    
      fileupload.bind "fileuploaddone", (event, data) ->
        callback data.jqXHR.getResponseHeader "Location"

      fileupload.click()

    scope.$watch "banner.content", (newVal, oldVal) ->
      lastValue[scope.banner.type] = newVal if scope.banner

    scope.$watch "banner.type", (newVal, oldVal) ->
      return unless newVal

      lastValue[oldVal] = scope.banner.content if oldVal
      scope.banner.content = lastValue[newVal] if lastValue[newVal]

      renderImage = ->
        image = $ """
          <img src="#{ scope.banner.content.image }" />
        """
        
        input = $ """
          <input type="text" value="#{ scope.banner.content.href || '' }" />
        """
        
        href = $ """
          <div>
            <label>Ссылка</label>
          </div>
        """
        
        href.append input
        input.on "blur", (e) ->
          scope.banner.content.href = input.val()

        banner = $ """
          <div style="float:none;" class="banners-detail-item
            banners-item banners-item__size-#{ scope.banner.size }">
          </div>
        """

        banner.on "click", (e) ->
          e.preventDefault()
          upload banner.width(), banner.height(), (src) ->
            image.attr "src", src
            scope.banner.content.image = src

        banner.append image
        $("<div>").append banner, href

      renderGallery = ->
        renderBanner = (index, data) ->
          image = $ "<img src='#{ data.image || '' }' />"
          banner = $ """
            <div class="banners-detail-item 
              banners-item banners-item__size-#{ scope.banner.size }">
            </div>
          """
          
          input = $ """
            <input type="text" value="#{ data.href }" />
          """

          href = $ """
            <div>
              <label>Ссылка</label>
            </div>
          """

          remove = $ """
            <button class="big_button" style="float:left">Удалить</button>
          """

          remove.on "click", (e) ->
            scope.banner.content.splice index, 1
            scope.$apply()
            $(e.target).parent().remove()

          href.append input
          input.on "blur", (e) ->
            scope.banner.content[index].href = input.val()
          
          banner.on "click", ->
            upload banner.width(), banner.height(), (src) ->
              image.attr "src", src
              scope.banner.content[index].image = src
          
          banner.append image
          $("<div style='clear:both;'>").append banner, href, remove
          
        banners = $ "<div>"

        scope.banner.content.forEach (image, index) ->
          banners.append renderBanner index, image

        button = $ """
          <button class='big_button'>
            Добавить
          </button>"
        """

        button.on "click", ->
          index = scope.banner.content.length
          scope.banner.content.push
            image: ""
            href: ""
          
          banners.append renderBanner index,
            image: ""
            href: ""

        buttonWrap = $ """
          <div style="clear:both;"></div>
        """

        buttonWrap.append button

        $("<div>").append banners, buttonWrap

      renderHtml = ->
        banner = $ """
          <div class="banners-detail-item 
            banners-item banners-item__size-#{ scope.banner.size }">
          </div>
        """
        
        textarea = $ "<textarea>#{ scope.banner.content }</textarea>"
        textarea.uniqueId()

        $timeout ->
          editor = CKEditor.replace textarea.attr "id"
          editor.on "change", (e) ->
            scope.banner.content = e.editor.getData()
            banner.html e.editor.getData()

        $("<div>").append banner, textarea

      renderFlash = ->
        
        banner = $ """
          <div class="banners-detail-item 
            banners-item banners-item__size-#{ scope.banner.size }">
          </div>
        """
        swf = $ "<div>"
        banner.append swf

        button = $ "<button class='big_button'>Загрузить</button>"
        
        button.on "click", ->
          upload (src) ->
            swfobject.embedSWF src, swf.get(0), banner.width(), banner.height(), 10
            scope.banner.content = src
        
        $("<div>").append banner, button

      types =
        "image": renderImage
        "gallery": renderGallery
        "html": renderHtml
        "flash": renderFlash

      element.html types[scope.banner.type]()
