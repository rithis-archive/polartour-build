window.polartour = angular.module "polartour", [
  "ui.select2"
  "ptTowns"
  "ptCountries"
  "ptTours"
  "ptHotels"
  "ptContacts"
  "ptReports"
  "ptOperators"
  "ptSubscriptions"
  "ptCertificates"
  "ptDocuments"
  "ptPhones"
  "ptTravallers"
  "ptFlightDates"
  "ptSelectRange"
  "ptButtonsGroup"
  "ptMultiField"
  "ptTypeahead"
  "ptSearch"
  "ptMoment"
  "ptYaMaps"
  "ptNews"
  "ptList"
  "ptGallery"
  "ptMenu"
  "ptBanners"
  "ptReservations"
  "ptExcursions"
  "ptPages"
  "ptCharges"
  "ptSwfobject"
  "ptDatepicker"
  "ptBack"
  "ptTarget"
  "ptFormDescriptions"
  "ptRadio"
  "ptCountField"
]


polartour.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"

polartour.config ($routeProvider) ->
  $routeProvider.when "/",
    templateUrl: "/views/index.html"
    controller: "IndexCtrl"

  $routeProvider.when "/:country/hotels",
    templateUrl: "/views/hotels.html"
    controller: "HotelsCtrl"

  $routeProvider.when "/:country/hotels/:id",
    templateUrl: "/views/hotel-detail.html"
    controller: "HotelCtrl"

  $routeProvider.when "/news",
    templateUrl: "/views/news.html"
    controller: "NewsCtrl"

  $routeProvider.when "/news/:id",
    templateUrl: "/views/news-detail.html"
    controller: "NewsDetailCtrl"

  $routeProvider.when "/contacts",
    templateUrl: "/views/contacts.html"
    controller: "ContactsCtrl"

  $routeProvider.when "/feedback",
    templateUrl: "/views/reports.html"
    controller: "ReportsCtrl"
  
  $routeProvider.when "/subscribtions",
    templateUrl: "/views/subscribe.html"
    controller: "SubscribeCtrl"

  $routeProvider.when "/ticket-price-request",
    templateUrl: "/views/certificates.html"
    controller: "CertificatesCtrl"

  $routeProvider.when "/documents-request",
    templateUrl: "/views/documents.html"
    controller: "DocumentsCtrl"

  $routeProvider.when "/reservation",
    templateUrl: "/views/reservation.html"
    controller: "ReservationCtrl"

  $routeProvider.when "/:country/excursions",
    templateUrl: "/views/excursions.html"
    controller: "ExcursionsCtrl"

  $routeProvider.when "/:country/charges",
    templateUrl: "/views/charges.html"
    controller: "ChargesCtrl"

  $routeProvider.otherwise
    templateUrl: "/views/pages.html"
    controller: "PagesCtrl"
