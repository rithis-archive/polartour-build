polartourAdmin.controller "BannersDetailCtrl", ($scope, $location, $routeParams, Banners) ->
  Banners.get id: $routeParams.id, (banner) ->
    $scope.banner = banner

  $scope.changeType = (type) ->
    $scope.banner.type = type

  $scope.save = ->
    $scope.banner.$update id: $scope.banner._id, ->
      $location.url "banners"

  $scope.remove = ->
    if confirm("""Вы точно хотите удалить этот баннер?""")
      $scope.banner.$remove id: $routeParams.id, ->
        $location.url "/banners"
