ptHotels = angular.module "ptHotels", ["ngResource"]


ptHotels.factory "Hotels", ($resource) ->
  $resource "/hotels/:id", {}, update: method:'PUT'

loadTheme = ->
  Galleria.addTheme
    name: "classic",
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


ptHotels.directive "ptHotels", ($timeout) ->
  link: (scope, element, attributes) ->
    scope.hotels = [
      "Gamberg 3*"
      "Gamberg 4*"
      "Gamberg 5*"
      "Kramerwirt 3*"
      "Kramerwirt 4*"
      "Kramerwirt 5*"
      "Aegean Pine 3*"
      "Aes Club 4*"
      "Agan 2*"
      "Agaoglu my Resort 4*"
      "Agrigento 4*"
      "Agripark 3*"
      "Ahmet Efendi Evi 3*"
      "Aideria 3*"
    ]

    trigger = """
      <div class="search-hotel-trigger">
        <span class="search-hotel-trigger-mask"></span>
        <div>
          <b></b>
        </div>
      </div>
    """

    $timeout ->
      choices = element.prev().find(".select2-choices")
      choices.children().each (index, choice) ->
        $(choice).on "click", ->
          element.select2 "open"

      choices.before trigger
      
      element.on "select2-close", (e) ->
        console.log ''

    element.on "change", (e) ->
      $timeout ->
        select = $(element).prev()
        choices = select.find(".select2-choices")
  
        width = 0
        choices.children().each (index, choice) ->
          width += $(choice).outerWidth()
  
        if width > select.width()
          choices.width width * 1.1
        
        unless choices.prev().length
          choices.before trigger


ptHotels.directive "ptHotelsImages", ($timeout) ->
  galleryElement = angular.element """
    <div id="galleria_{{ gallery_id }}">
      <img ng-repeat="banner in banners" src="{{ banner }}">
    </div>
  """

  link: (scope, element, attributes) ->
    scope.scrollTo = (banner) ->
      scope.listposition = left: (210 * banner * -1) + "px"
      element.find(".active").removeClass "active"
      element.find(".hotel-description-banners-thumb:nth-child(#{banner + 1})")
        .addClass "active"

    scope.showGallery = (index) ->
      GALLERY_ID = Date.now()
      gallery = $ """
        <div  id='galleria_#{ GALLERY_ID }'
          class='hotel-description-gallery'></div>
      """
      close = $ "<div class='hotel-description-gallery-close'></div>"
      backdrop = $ "<div class='hotel-description-gallery-backdrop'></div>"
      wrapper = $ "<div class='hotel-description-gallery-wrapper'>"
      banners = []
      images = angular.copy scope.hotel.images
      angular.forEach images.splice(index, images.length), (banner) ->
        banners.push "<img src='#{ banner }'>"
      angular.forEach images, (banner) ->
        banners.push "<img src='#{ banner }'>"
      gallery.append banners

      wrapper.append close, gallery
      element.append wrapper
      
      Galleria.unloadTheme()
      loadTheme()

      Galleria.run "#galleria_#{ GALLERY_ID }"

      backdrop.height $(document).height()
      $('body').append backdrop

      close.on "click", ->
        wrapper.remove()
        backdrop.remove()
