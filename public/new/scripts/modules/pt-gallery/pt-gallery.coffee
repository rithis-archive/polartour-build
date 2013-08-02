ptGallery = angular.module "ptGallery", []

ptGallery.factory "ptGalleryPopupProxy", ->
  open: (images, selectedImage, @selectCallback) ->
    @openCallback images, selectedImage if @openCallback
  select: (@selectedImage) ->
    @selectCallback @selectedImage

ptGallery.directive "ptGalleryPopup", ($document, ptGalleryPopupProxy) ->
  restrict: "E"
  replace: true
  templateUrl: "scripts/modules/pt-gallery/pt-gallery-popup.html"
  scope: ptGalleryMaxWidth: "@"
  link: (scope, element) ->
    scope.maxWidth = 0
    scope.opened = false

    scope.$watch "ptGalleryMaxWidth", (maxWidth) ->
      scope.maxWidth = if maxWidth then Number(maxWidth) or 700

    ptGalleryPopupProxy.openCallback = (images, selectedImage) ->
      scope.images = images
      scope.selectedImage = selectedImage
      scope.firstImage = images[0]
      scope.lastImage = images[images.length-1]
      scope.opened = true
      scope.resize()

    getNaturalImageSize = (src) ->
      img = new Image
      img.src = src
      width: img.width
      height: img.height

    scope.resize = ->
      img = element.find "img"
      img.on "load", ->
        size = getNaturalImageSize img.attr("src")
        width = size.width
        height = size.height

        if scope.maxWidth > 0 and width > scope.maxWidth
          scale = scope.maxWidth / width
          width = scope.maxWidth
          height = height * scale

        img.width width
        img.height height
        popup.width width
        popup.height height
        popup.css "margin-left", String(popup.outerWidth() / -2) + "px"

    scope.prev = ->
      prev = null
      for image in scope.images
        if scope.selectedImage is image and prev
          ptGalleryPopupProxy.select prev
          scope.selectedImage = prev
          scope.resize()
          break
        prev = image

    scope.next = ->
      next = false
      for image in scope.images
        if next
          ptGalleryPopupProxy.select image
          scope.selectedImage = image
          scope.resize()
          break
        if image == scope.selectedImage
          next = true

    scope.close = ->
      scope.opened = false

    safeApply = (callback) ->
      if scope.$root.$$phase in ["$apply", "$digest"]
        callback()
      else
        scope.$apply callback

    popup = element.find ".popup"

    $document.bind "keyup", (event) ->
      if scope.opened
        switch event.keyCode
          when 37 # left
            safeApply ->
              scope.prev()
          when 39 # right
            safeApply ->
              scope.next()


ptGallery.directive "ptGallery", (ptGalleryPopupProxy) ->
  restrict: "E"
  replace: true
  templateUrl: "scripts/modules/pt-gallery/pt-gallery.html"
  scope: ptGalleryImages: "="
  link: (scope, element) ->
    scope.$watch "ptGalleryImages", (images) ->
      return unless images
      scope.selectedImage = images[0]

    scope.openPopup = ->
      ptGalleryPopupProxy.open scope.ptGalleryImages, scope.selectedImage, (selectedImage) ->
        scope.selectedImage = selectedImage

    scope.selectImage = (image) ->
      scope.selectedImage = image

    scope.isSelected = (image) ->
      scope.selectedImage is image
