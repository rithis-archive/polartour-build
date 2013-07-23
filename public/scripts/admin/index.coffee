window.polartourAdmin = angular.module "polartourAdmin", [
  "ui.select2"
  "blueimp.fileupload"
  "ptTowns"
  "ptCountries"
  "ptTours"
  "ptContacts"
  "ptReports"
  "ptHotels"
  "ptNews"
  "ptSubscriptions"
  "ptCertificates"
  "ptDocuments"
  "ptPhones"
  "ptList"
  "ptButtonsGroup"
  "ptEditableSelect"
  "ptUploadImage"
  "ptMultiField"
  "ptTypeahead"
  "ptDatepicker"
  "ptModal"
  "ptYaMaps"
  "ptMoment"
  "ptEmployees"
  "ptRooms"
  "ptMenu"
  "ptEditMenu"
  "ptBanners"
  "ptBannersEdit"
  "ptCharges"
  "ptReservations"
  "ptExcursions"
  "ptPages"
  "ptCKEditor"
  "ptSwfobject"
  "ptPermissions"
  "ptUsers"
  "ptFormDescriptions"
  "ptRegions"
  "ptMenuEdit"
  "ptGallery"
  "ptFiles"
]


polartourAdmin.config ($httpProvider) ->
  $httpProvider.responseInterceptors.push ($location, $cookieStore) ->
    (promise) ->
      success = (response) ->
        response

      error = (response) ->
        if response.status == 401
          $cookieStore.remove "token"
          $location.path "/login"
        response

      promise.then success, error


polartourAdmin.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"

polartourAdmin.config ($routeProvider) ->
  $routeProvider.when "/",
    templateUrl: "/views/admin/index.html"
    controller: "IndexCtrl"

  $routeProvider.when "/login",
    templateUrl: "/views/admin/login.html"
    controller: "LoginCtrl"

  $routeProvider.when "/menu",
    templateUrl: "/views/admin/menu.html"
    controller: "MenuCtrl"

  $routeProvider.when "/banners",
    templateUrl: "/views/admin/banners.html"
    controller: "BannersCtrl"

  $routeProvider.when "/banners/:id",
    templateUrl: "/views/admin/banners-detail.html"
    controller: "BannersDetailCtrl"

  $routeProvider.when "/hotels",
    templateUrl: "/views/admin/hotels.html"
    controller: "HotelsCtrl"

  $routeProvider.when "/hotels/:id",
    templateUrl: "/views/admin/hotels-detail.html"
    controller: "HotelsDetailCtrl"

  $routeProvider.when "/news",
    templateUrl: "/views/admin/news.html"
    controller: "NewsCtrl"

  $routeProvider.when "/news/:id",
    templateUrl: "/views/admin/news-detail.html"
    controller: "NewsDetailCtrl"

  $routeProvider.when "/news/:id/:clone",
    templateUrl: "/views/admin/news-detail.html"
    controller: "NewsDetailCtrl"

  $routeProvider.when "/contacts",
    templateUrl: "/views/admin/contacts.html"
    controller: "ContactsCtrl"

  $routeProvider.when "/contacts/:id",
    templateUrl: "/views/admin/contacts-detail.html"
    controller: "ContactsDetailCtrl"

  $routeProvider.when "/feedbacks",
    templateUrl: "/views/admin/reports.html"
    controller: "ReportsCtrl"

  $routeProvider.when "/feedbacks/:id",
    templateUrl: "/views/admin/reports-detail.html"
    controller: "ReportsDetailCtrl"

  $routeProvider.when "/subscriptions",
    templateUrl: "/views/admin/subscriptions.html"
    controller: "SubscriptionsCtrl"

  $routeProvider.when "/subscriptions/:id",
    templateUrl: "/views/admin/subscriptions-detail.html"
    controller: "SubscriptionsDetailCtrl"
    
  $routeProvider.when "/ticket-price-requests",
    templateUrl: "/views/admin/certificates.html"
    controller: "CertificatesCtrl"

  $routeProvider.when "/ticket-price-requests/:id",
    templateUrl: "/views/admin/certificates-detail.html"
    controller: "CertificationsDetailCtrl"
    
  $routeProvider.when "/documents-requests",
    templateUrl: "/views/admin/documents.html"
    controller: "DocumentsCtrl"

  $routeProvider.when "/documents-requests/:id",
    templateUrl: "/views/admin/documents-detail.html"
    controller: "DocumentsDetailCtrl"
    
  $routeProvider.when "/towns",
    templateUrl: "/views/admin/towns.html"
    controller: "TownsCtrl"

  $routeProvider.when "/towns/:id",
    templateUrl: "/views/admin/towns-detail.html"
    controller: "TownsDetailCtrl"

  $routeProvider.when "/phones",
    templateUrl: "/views/admin/phones.html"
    controller: "PhonesCtrl"

  $routeProvider.when "/phones/:id",
    templateUrl: "/views/admin/phones-detail.html"
    controller: "PhonesDetailCtrl"

  $routeProvider.when "/charges",
    templateUrl: "/views/admin/charges.html"
    controller: "ChargesCtrl"

  $routeProvider.when "/charges/:id",
    templateUrl: "/views/admin/charges-detail.html"
    controller: "ChargesDetailCtrl"

  $routeProvider.when "/reservations",
    templateUrl: "/views/admin/reservations.html"
    controller: "ReservationsCtrl"

  $routeProvider.when "/reservations/:id",
    templateUrl: "/views/admin/reservations-detail.html"
    controller: "ReservationsDetailCtrl"

  $routeProvider.when "/pages",
    templateUrl: "/views/admin/pages.html"
    controller: "PagesCtrl"

  $routeProvider.when "/pages/:id",
    templateUrl: "/views/admin/pages-detail.html"
    controller: "PagesDetailCtrl"

  $routeProvider.when "/excursions",
    templateUrl: "/views/admin/excursions.html"
    controller: "ExcursionsCtrl"

  $routeProvider.when "/excursions/:id",
    templateUrl: "/views/admin/excursions-detail.html"
    controller: "ExcursionsDetailCtrl"

  $routeProvider.when "/groups",
    templateUrl: "/views/admin/groups.html"
    controller: "GroupsCtrl"

  $routeProvider.when "/groups/:id",
    templateUrl: "/views/admin/groups-detail.html"
    controller: "GroupsDetailCtrl"

  $routeProvider.when "/users",
    templateUrl: "/views/admin/users.html"
    controller: "UsersCtrl"

  $routeProvider.when "/users/:id",
    templateUrl: "/views/admin/users-detail.html"
    controller: "UsersDetailCtrl"

  $routeProvider.when "/form-descriptions",
    templateUrl: "/views/admin/form-descriptions.html"
    controller: "FormDescriptionsCtrl"

  $routeProvider.when "/form-descriptions/:code",
    templateUrl: "/views/admin/form-descriptions-detail.html"
    controller: "FormDescriptionsDetailCtrl"

  $routeProvider.when "/files",
    templateUrl: "/views/admin/files.html"
    controller: "FilesCtrl"
