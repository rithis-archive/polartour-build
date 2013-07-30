ptGallery = angular.module "ptGallery", []

ptGallery.factory "ptGalleryPopupProxy", ->
  open: (images, selectedImage, @selectCallback) ->
    @openCallback images, selectedImage if @openCallback
  select: (@selectedImage) ->
    @selectCallback @selectedImage

ptGallery.directive "ptGalleryPopup", (ptGalleryPopupProxy) ->
  restrict: "E"
  replace: true
  templateUrl: "scripts/modules/pt-gallery/pt-gallery-popup.html"
  scope: {}
  link: (scope, element) ->
    scope.opened = false

    ptGalleryPopupProxy.openCallback = (images, selectedImage) ->
      scope.images = images
      scope.selectedImage = selectedImage
      scope.firstImage = images[0]
      scope.lastImage = images[images.length-1]
      scope.opened = true

    scope.prev = ->
      prev = null
      for image in scope.images
        if scope.selectedImage is image
          ptGalleryPopupProxy.select prev
          scope.selectedImage = prev
          break
        prev = image

    scope.next = ->
      next = false
      for image in scope.images
        if next
          ptGalleryPopupProxy.select image
          scope.selectedImage = image
          break
        if image == scope.selectedImage
          next = true

    scope.close = ->
      scope.opened = false

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
