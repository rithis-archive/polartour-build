ptBanners = angular.module "ptBanners", [
  "ngResource"
]

ptBanners.factory "ptBanner", ($resource) ->
  $resource "/banners"

ptBanners.controller "BannerGalleryCtrl", ($scope) ->
  timeout = 3000

  scrollTo = (banner, clear) =>
    if banner
      $scope.current = banner
    else if $scope.banner.content.length == $scope.current + 1
      $scope.current = 0
    else
      $scope.current++

    $scope.listposition = left: ($scope.width * $scope.current * -1) + "px"

    $scope.$apply() unless clear

  $scope.current = 0
  $scope.scrollTo = scrollTo

  interval = setInterval scrollTo, timeout
  
  $scope.select = (banner) =>
    clearInterval interval
    scrollTo banner, true
    interval = setInterval scrollTo, timeout


ptBanners.directive "ptBanner", ($http, $compile, $templateCache) ->
  restrict: "EACM"
  compile: (element, attrs) ->
    (scope, element, attrs) ->
      sizes =
        "1x1": "small"
        "2x1": "double"
        "2x2": "big"
        "3x1": "wide"
        "3x2": "biggest"
  
      scope.getSize = (size) -> sizes[size]

ptBanners.directive "ptBanners", (ptBanner, $http, $compile, $templateCache, $controller, $timeout, $filter) ->
  restrict: "EACM"
  replace: true
  link: (scope, element) ->
    ptBanner.query (data) ->
      banners = []
      $filter("orderBy")(data, "+position").forEach (banner, index) ->
        tpl = "scripts/modules/pt-banners/pt-banners-#{banner.type}.html"
        $http.get(tpl, cache: $templateCache)
          .then ( response ) ->
            templateScope = scope.$new()
            templateScope.banner = banner
            templateElement = angular.element response.data
            banners[index] = $compile(templateElement)(templateScope)
            if banner.type is "gallery"
              templateCtrl = $controller "BannerGalleryCtrl",
                $scope: templateScope 
              $timeout ->
                templateScope.width = templateElement.width()
            if banners.length is data.length
              element.append banners
