polartourAdmin.controller "ConfigsCtrl", ($scope, $location, Configs) ->
  $scope.data = Configs.query()

  $scope.new = ->
    $location.url "/configs/new"
