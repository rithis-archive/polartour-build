ptSupplements = angular.module "ptSupplements", [
  "ngResource"
]

ptSupplements.factory "ptSupplement", ($resource) ->
  $resource "/charges"

ptSupplements.controller "PtSupplementsCtrl", ($scope, $routeParams, $filter, ptSupplement, ptCountriesManager) ->
  $scope.country =  ptCountriesManager.getGenitiveByCode $routeParams.country

  ptSupplement.query (supplements) ->
    $scope.supplements = $filter("filter") supplements,
      country: $routeParams.country

    countries = []
    supplements.forEach (supplement) ->
      if countries.indexOf(supplement.country) == -1 \
        and $routeParams.country != supplement.country
          countries.push supplement.country
    $scope.countries = countries

  $scope.getCountryName = (code) ->
    ptCountriesManager.getName code
