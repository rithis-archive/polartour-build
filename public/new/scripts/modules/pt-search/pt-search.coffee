ptSearch = angular.module "ptSearch", [
  "ptRegion"
]

ptSearch.controller "PtFastSearchCtrl", ($scope, ptCountriesManager, ptRegion) ->
  $scope.search =
    from: ptRegion.getRegion()
    to: "tr"
    date: new Date Date.now() + 1000 * 60 * 60 * 24 * 14
    nights: 7

  $scope.values =
    from: ptRegion.regions
    to: ptCountriesManager.countries
