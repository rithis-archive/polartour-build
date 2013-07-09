polartourAdmin.controller "TownsCtrl", ($scope, $location, Towns) ->
  $scope.data = Towns.query()

  $scope.new = ->
    $location.url "/towns/new"
