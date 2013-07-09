polartour.controller "ExcursionsCtrl", ($scope, $location, $filter, $routeParams, Excursions, ptCountriesManager) ->
  $scope.country =  ptCountriesManager.getName $routeParams.country

  Excursions.query (excursions) ->
    $scope.excursions = $filter("filter") excursions,
      country: $routeParams.country

    countries = []
    excursions.forEach (excursion) ->
      if countries.indexOf(excursion.country) == -1 \
        and $routeParams.country != excursion.country
          countries.push excursion.country
    $scope.countries = countries
    
  $scope.scrollTo = (country) ->
    $.scrollTo "##{country}"

  $scope.getGenitive = ptCountriesManager.getGenitive