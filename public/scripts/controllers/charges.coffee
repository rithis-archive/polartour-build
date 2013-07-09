polartour.controller "ChargesCtrl", ($scope, $routeParams, Charges, ptCountriesManager) ->
  Charges.query country: $routeParams.country, (data) ->
    $scope.data = data
    
    $scope.countries = ptCountriesManager.all()
    $scope.country = ptCountriesManager.getName $routeParams.country
    
    $scope.getGenitive = ptCountriesManager.getGenitive
