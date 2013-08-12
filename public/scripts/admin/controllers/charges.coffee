polartourAdmin.controller "ChargesCtrl", ($scope, $location, Charges) ->
  $scope.data = Charges.query()

  $scope.types = [
    {
      code: "transfers"
      name: "Трансфер"
    }
    {
      code: "flights"
      name: "Перелет"
    }
  ]

  $scope.new = ->
    $location.url "/charges/new"
