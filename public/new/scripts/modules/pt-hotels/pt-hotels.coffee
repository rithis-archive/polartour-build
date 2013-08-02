ptHotels = angular.module "ptHotels", [
  "ngResource"
]

ptHotels.factory "ptHotel", ($resource) ->
  $resource "/hotels/:_id"

ptHotels.controller "PtHotelsCtrl", ($scope, $routeParams, $filter, ptHotel, ptCountriesManager) ->
  $scope.country =  ptCountriesManager.getGenitiveByCode $routeParams.country

  fetchUnique = (hotels, field) ->
    hotels.map (hotel) ->
      hotel[field]
    .filter (value, index, self) ->
      value and value.length > 0 and self.indexOf(value) is index
    .sort()

  ptHotel.query country: $routeParams.country, (hotels, headers) ->
    $scope.hotels = hotels

    $scope.hotelRegions = fetchUnique hotels, "region"
    $scope.hotelRegions.unshift ""
    $scope.hotelCategories = fetchUnique hotels, "category"
    $scope.hotelCategories.unshift ""

    countries = []
    headers("Link").split(",").forEach (header) ->
      href = header.split(";")[0].replace(/^(\s*)|(\s*)$/g, "")
        .replace(/\s+/g, " ")
      country = href.replace "/hotels?country=", ""
      unless country == $routeParams.country
        countries.push country
    $scope.countries = countries

  $scope.getCountryName = (code) ->
    ptCountriesManager.getName code

ptHotels.controller "PtHotelCtrl", ($scope, $routeParams, ptHotel) ->
  $scope.hotel = ptHotel.get _id: $routeParams.hotelId
