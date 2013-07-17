polartour.controller "IndexCtrl", ($scope, $http, ptFlightDatesManager) ->
  $scope.flightFromDate = ptFlightDatesManager.fromDate
  $scope.flightToDate = ptFlightDatesManager.toDate

  req = $http method: "GET", url: "/rates"
  req.success (data, status, headers, config) ->
    data.rows = []

    for date of data.rates
      row = date: date, rates: []

      for currency in data.currencies
        row.rates.push data.rates[date][currency]

      data.rows.push row

    $scope.rates = data
