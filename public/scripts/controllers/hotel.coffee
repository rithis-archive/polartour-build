polartour.controller "HotelCtrl", ($scope, $routeParams, Hotels, ptCountriesManager) ->
  $scope.hotel = Hotels.get id: $routeParams.id
  
  $scope.countries = ptCountriesManager.all()
  $scope.country = ptCountriesManager.getName $routeParams.country
