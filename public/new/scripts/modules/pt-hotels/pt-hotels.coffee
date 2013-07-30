ptHotels = angular.module "ptHotels", [
  "ngResource"
]

ptHotels.factory "ptHotel", ($resource) ->
  $resource "/hotels/:_id"

ptHotels.controller "PtHotelsCtrl", ($scope, $routeParams, ptHotel) ->
  ptHotel.query country: $routeParams.country, (hotels) ->
    $scope.hotels = hotels
    $scope.hotelRegions = hotels.map (hotel) ->
      hotel.region
    $scope.hotelRegions = $scope.hotelRegions.filter (value, index, self) ->
      self.indexOf(value) is index
    $scope.hotelRegions.unshift ""

ptHotels.controller "PtHotelCtrl", ($scope, $routeParams, ptHotel) ->
  $scope.hotel = ptHotel.get _id: $routeParams.hotelId
