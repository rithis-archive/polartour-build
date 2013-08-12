pt = angular.module "pt", [
  "ptSelect"
  "ptMenu"
  "ptRegion"
  "ptCountries"
  "ptPhones"
  "ptNews"
  "ptRange"
  "ptPassengers"
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
  "ptFeedback"
  "ptBookingRequest"
  "ptRadio"
  "ptAccountingDocuments"
  "ptAirfares"
]

pt.filter "escape", ->
  (value) ->
    if value
      value.replace /</g, "&lt;"
    else
      ""

pt.filter "nl2br", ->
  (value) ->
    if value
      value.replace /\n/mg, "<br>"
    else
      ""

pt.factory "ptSamo", ->
  baseUrl = "http://polartour.ru/samo"
  baseUrl: baseUrl
  personalCabinet: baseUrl + "/cl_refer"
  openPersonalCabinet: ->
    window.location.href = @personalCabinet

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

  $routeProvider.when "/:country/supplements/:supplementType",
    templateUrl: "views/supplements.html"
    controller: "PtSupplementsCtrl"

  $routeProvider.when "/airfares",
    controller: "PtAirfaresCtrl"
    templateUrl: "views/airfares.html"

  $routeProvider.when "/accounting-documents",
    controller: "PtAccountingDocumentsCtrl"
    templateUrl: "views/accounting-documents.html"

  $routeProvider.when "/booking-request",
    controller: "PtBookingRequestCtrl"
    templateUrl: "views/booking-request.html"

  $routeProvider.when "/feedback",
    controller: "PtFeedbackCtrl"
    templateUrl: "views/feedback.html"

  $routeProvider.when "/subscribtion",
    controller: "PtSubscribtionCtrl"
    templateUrl: "views/subscribtion.html"

  $routeProvider.when "/test",
    templateUrl: "views/test.html"
    controller: ($scope) ->
      $scope.calendar1 = value: new Date

  $routeProvider.otherwise
    controller: "PtPagesCtrl"
    templateUrl: "views/content.html"
