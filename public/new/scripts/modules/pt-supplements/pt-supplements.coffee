ptSupplements = angular.module "ptSupplements", [
  "ngResource"
]

ptSupplements.factory "ptSupplement", ($resource) ->
  $resource "/charges"

ptSupplements.controller "PtSupplementsCtrl", ($scope, $routeParams, $filter, ptSupplement, ptCountriesManager) ->
  $scope.country =  ptCountriesManager.getGenitiveByCode $routeParams.country

  $scope.title = switch $routeParams.supplementType
    when "transfers"
      "Трансферы"
    when "flights"
      "Доплаты за рейсы"
    else
      "Доплаты"

  ptSupplement.query (supplements) ->
    $scope.supplements = $filter("filter") supplements,
      country: $routeParams.country
      type: $routeParams.supplementType

    countries = []
    supplements.forEach (supplement) ->
      if countries.indexOf(supplement.country) == -1 \
        and $routeParams.country != supplement.country
          countries.push supplement.country
    $scope.countries = countries

  $scope.getCountryName = (code) ->
    ptCountriesManager.getName code
