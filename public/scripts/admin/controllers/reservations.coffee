polartourAdmin.controller "ReservationsCtrl", ($scope, Reservations) ->
  $scope.data = Reservations.query()
