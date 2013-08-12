polartourAdmin.controller "ReservationsDetailCtrl", ($scope, $location, $routeParams, Reservations) ->
  $scope.reservation = Reservations.get id: $routeParams.id
  
  $scope.remove = ->
    if confirm("""Вы точно хотите удалить эту заявку?""")
      $scope.reservation.$remove id: $routeParams.id, ->
        $location.url "/reservations"

  $scope.changeProcessed = ->
    $scope.reservation.$update id: $routeParams.id