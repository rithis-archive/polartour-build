polartourAdmin.controller "ChargesCtrl", ($scope, $location, Charges) ->
  $scope.data = Charges.query()

  $scope.new = ->
    $location.url "/charges/new"
