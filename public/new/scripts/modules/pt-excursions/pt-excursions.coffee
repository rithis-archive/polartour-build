ptExcursions = angular.module "ptExcursions", [
  "ngResource"
]

ptExcursions.factory "ptExcursion", ($resource) ->
  $resource "/excursions"

ptExcursions.controller "PtExcursionsCtrl", ($scope, $routeParams, ptExcursion, ptExcursionsScroll) ->
  $scope.excursions = ptExcursion.query country: $routeParams.country

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
