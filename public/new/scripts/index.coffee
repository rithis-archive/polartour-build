pt = angular.module "pt", [
  "ptSelect"
  "ptMenu"
  "ptCountries"
  "ptPhones"
  "ptNews"
  "ptExchangeRates"
  "ptSearch"
  "ptPagination"
  "ptBanners"
  "ptHotels"
  "ptMap"
  "ptNumber"
  "ptContacts"
  "ptPages"
  "ptGallery"
  "ptExcursions"
  "ptSupplements"
  "ptCalendar"
  "ptCheckbox"
  "ptSubscribtion"
  "ptFormDescriptions"
]

pt.filter "escape", ->
  (value) ->
    value.replace /</g, "&lt;"

pt.filter "nl2br", ->
  (value) ->
    value.replace /\n/mg, "<br>"

pt.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"

pt.config ($routeProvider) ->
  $routeProvider.when "/",
    templateUrl: "views/index.html"

  $routeProvider.when "/:country/hotels",
    templateUrl: "views/hotels.html"
    controller: "PtHotelsCtrl"

  $routeProvider.when "/:country/hotels/:hotelId",
    templateUrl: "views/hotel.html"
    controller: "PtHotelCtrl"

  $routeProvider.when "/contacts",
    controller: "PtContactsCtrl"
    templateUrl: "views/contacts.html"

  $routeProvider.when "/news",
    templateUrl: "views/all-news.html"
    controller: "PtAllNewsCtrl"

  $routeProvider.when "/news/:newsId",
    templateUrl: "views/news.html"
    controller: "PtNewsCtrl"

  $routeProvider.when "/:country/excursions",
    templateUrl: "views/excursions.html"
    controller: "PtExcursionsCtrl"

  $routeProvider.when "/:country/supplements",
    templateUrl: "views/supplements.html"
    controller: "PtSupplementsCtrl"

  $routeProvider.when "/airfares",
    templateUrl: "views/airfares.html"

  $routeProvider.when "/accounting-documents",
    templateUrl: "views/accounting-documents.html"

  $routeProvider.when "/booking-request",
    templateUrl: "views/booking-request.html"

  $routeProvider.when "/feedback",
    templateUrl: "views/feedback.html"

  $routeProvider.when "/subscribtion",
    controller: "PtSubscribtionCtrl"
    templateUrl: "views/subscribtion.html"

  $routeProvider.when "/test",
    templateUrl: "views/test.html"

  $routeProvider.otherwise
    controller: "PtPagesCtrl"
    templateUrl: "views/content.html"
