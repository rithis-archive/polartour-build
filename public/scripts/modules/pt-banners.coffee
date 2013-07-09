ptBanners = angular.module "ptBanners", ["ngResource"]


ptBanners.factory "Banners", ($resource) ->
  $resource "/banners/:id", {}, update: method:'PUT'


ptBanners.directive "ptBanners", (Banners) ->
  (scope, element) ->
    scope.banners = Banners.query()

ptBanners.directive "ptBanner", ($compile, $location, $timeout) ->
  link: (scope, element, attrs) ->
    scope.goTo = (href) ->
      return if /admin/.test location.href
      location.href = href

    $timeout ->
      types =
        "image": """
          <img ng-src="{{ banner.content.image }}" 
            ng-click="goTo(banner.content.href)"/>
        """
        "html": """
          <div ng-bind-html-unsafe='banner.content' class='banners-item-html'>
        """
        "flash": """
          <div pt-swfobject ng-model='banner.content'
            style="width:#{element.width()}px; height:#{element.height()}px;"
          >
        """

      types.gallery = "<div pt-gallery ng-model='banner'>"

      element.html $compile(types[scope.banner.type])(scope)
