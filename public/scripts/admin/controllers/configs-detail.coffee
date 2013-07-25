polartourAdmin.controller "ConfigsDetailCtrl", ($scope, $location, $routeParams, Configs) ->
  $scope.config = if $routeParams.id is "new" then new Configs \
    else Configs.get id: $routeParams.id

  $scope.save = ->
    return unless $scope.configForm.$valid
    callback = ->
      $location.url "configs"
    if $routeParams.id == "new"
      $scope.config.$save callback
    else
      $scope.config.$update id: $routeParams.id, callback

  $scope.remove = ->
    if $routeParams.id == "new"
      $location.url "/configs"
    else if confirm("""Вы точно хотите удалить "#{$scope.config.property}"?""")
      $scope.config.$remove id: $routeParams.id, ->
        $location.url "/configs"
