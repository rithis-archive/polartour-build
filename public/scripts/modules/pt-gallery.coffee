ptGallery = angular.module "ptGallery", []

loadTheme = ->
  Galleria.addTheme
    name: "index",
    author: "Rithis",
    defaults:
      transition: "slide"
      thumbCrop:  "height"
      _toggleInfo: true
    init: (options) ->
      Galleria.requires 1.28, "Requires Galleria 1.2.8 or later"

      @addElement "info-link", "info-close"
      @append "info" : ["info-link", "info-close"]

      info = @$("info-link,info-close,info-text")
      touch = Galleria.TOUCH
      click = touch ? "touchstart" : "click"

      @$("loader,counter").show().css "opacity", 0.4

      unless touch 
        @addIdleState @get("image-nav-left"), left: -50
        @addIdleState @get("image-nav-right"), right: -50
        @addIdleState @get("counter"), opacity: 0

      if options._toggleInfo == true
        info.bind click, -> info.toggle()
      else
        info.show()
        @$("info-link, info-close").hide()


      @bind "thumbnail", (e) ->
        if !touch
          $(e.thumbTarget).css("opacity", 0.6).parent().hover ->
            $(@).not(".active").children().stop().fadeTo 100, 1
          , ->
            $(@).not(".active").children().stop().fadeTo 400, 0.6


          if e.index == @getIndex()
            $(e.thumbTarget).css "opacity", 1
        else
          $(e.thumbTarget).css "opacity", @getIndex() ? 1 : 0.6


      @bind "loadstart", (e) ->
        unless e.cached
          @$('loader').show().fadeTo 200, 0.4

          @$('info').toggle @hasInfo()

          $(e.thumbTarget).css("opacity",1).parent()
            .siblings().children().css "opacity", 0.6

      @bind "loadfinish", (e) ->
        @$("loader").fadeOut 200

ptGallery.directive "ptGallery", ($timeout, $location) ->
  link: (scope, element, attributes) ->
    GALLERY_ID = (new Date()).getTime()
    gallery = $ "<div id='#{GALLERY_ID}'>"

    banners = []
    isAdmin = /admin/.test location.href
    model = scope.$eval(attributes.ngModel)
    model.content.forEach (banner) ->
      banners.push
        thumb: "/images/radio.png"
        image: banner.image
        big: banner.image
        link: if isAdmin then "#!/banners/#{model._id}" else banner.href

    gallery.append banners
    element.append gallery

    Galleria.unloadTheme()
    loadTheme()

    Galleria.run "##{GALLERY_ID}",
      autoplay: true
      preload: "all"
      dataSource: banners
