ptExcursions = angular.module "ptExcursions", [
  "ngResource"
]

ptExcursions.factory "ptExcursion", ($resource) ->
  $resource "/excursions"

ptExcursions.controller "PtExcursionsCtrl", ($scope, $routeParams, $filter, ptExcursion, ptExcursionsScroll, ptCountriesManager) ->
  $scope.country =  ptCountriesManager.getGenitiveByCode $routeParams.country

  ptExcursion.query (excursions) ->
    $scope.excursions = $filter("filter") excursions,
      country: $routeParams.country

    countries = []
    excursions.forEach (excursion) ->
      if countries.indexOf(excursion.country) == -1 \
        and $routeParams.country != excursion.country
          countries.push excursion.country
    $scope.countries = countries

  $scope.getCountryName = (code) ->
    ptCountriesManager.getName code

  $scope.scroll = (excursion) ->
    ptExcursionsScroll.scroll excursion._id

ptExcursions.factory "ptExcursionsScroll", ->
  excursions: {}
  scroll: (id) ->
    scrollTo 0, @excursions[id].offset().top

ptExcursions.directive "ptExcursion", (ptExcursionsScroll) ->
  link: (scope, element, attributes) ->
    attributes.$observe "ptExcursion", (id) ->
      return unless id
      ptExcursionsScroll.excursions[id] = element
      console.log ptExcursionsScroll
