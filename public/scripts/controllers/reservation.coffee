polartour.controller "ReservationCtrl", ($scope, $location, Reservations, FormDescriptions) ->
  $scope.reservation = new Reservations
    nights: 3
  
  $scope.description = FormDescriptions.get code: "reservations"
  
  $scope.save = ->
    if $scope.reservationForm.$valid
      $scope.reservation.$save ->
        alert "Ваш запрос успешно сохранен."
        $location.url "/"
