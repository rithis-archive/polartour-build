ptExchangeRates = angular.module "ptExchangeRates", []

ptExchangeRates.controller "PtExchangeRatesCtrl", ($scope, $http) ->
  req = $http method: "GET", url: "/rates"
  req.success (data, status, headers, config) ->
    data.rows = []

    for date of data.rates
      row = date: date, rates: []

      for currency in data.currencies
        row.rates.push data.rates[date][currency]

      data.rows.push row

    $scope.rates = data
