polartourAdmin.controller "TownsDetailCtrl", ($scope, $location, $routeParams, Towns) ->
  $scope.town = Towns.get id: $routeParams.id

  $scope.save = ->
    callback = ->
      $location.url "towns"
    if $routeParams.id == "new"
      $scope.town.$save callback
    else
      $scope.town.$update id: $routeParams.id, callback

  $scope.remove = ->
    if $routeParams.id == "new"
      $location.url "/towns"
    else if confirm("""Вы точно хотите удалить "#{$scope.town.name}"?""")
      $scope.town.$remove id: $routeParams.id, ->
        $location.url "/towns"
