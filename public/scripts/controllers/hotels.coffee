polartour.controller "HotelsCtrl", ($scope, $routeParams, Hotels, ptCountriesManager) ->
  Hotels.query country: $routeParams.country, (data) ->
    $scope.data = data

    regions = [""]
    data.forEach (hotel) ->
      regions.push hotel.region if regions.indexOf(hotel.region) == -1
    $scope.regions = regions

    $scope.countries = ptCountriesManager.all()
    $scope.country = ptCountriesManager.getName $routeParams.country
    
    $scope.getGenitive = ptCountriesManager.getGenitive
