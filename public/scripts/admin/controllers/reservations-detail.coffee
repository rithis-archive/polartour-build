polartourAdmin.controller "ReservationsDetailCtrl", ($scope, $location, $routeParams, Reservations) ->
  $scope.reservation = Reservations.get id: $routeParams.id
