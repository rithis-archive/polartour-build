polartour.controller "IndexCtrl", ($scope, ptFlightDatesManager) ->
  $scope.flightFromDate = ptFlightDatesManager.fromDate
  $scope.flightToDate = ptFlightDatesManager.toDate
