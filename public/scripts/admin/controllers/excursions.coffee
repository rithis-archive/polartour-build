polartourAdmin.controller "ExcursionsCtrl", ($scope, $location, Excursions, ptCountriesManager) ->
  $scope.data = Excursions.query()

  $scope.getCountryName = (code) ->
    ptCountriesManager.getName code

  $scope.new = ->
    $location.url "/excursions/new"
