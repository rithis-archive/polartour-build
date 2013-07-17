polartourAdmin.controller "HotelsDetailCtrl", ($scope, $location, $routeParams, Hotels) ->
  if $routeParams.id is "new"
    $scope.hotel = new Hotels
      location: ["55.752740469686", "37.605274203168"]
      country: $routeParams.country if $routeParams.country
  else
    $scope.hotel = Hotels.get id: $routeParams.id

  Hotels.query (hotels) ->
    regions = []
    services = []
    infrastructures = []
    hotels.forEach (hotel) ->
      if regions.indexOf(hotel.region) == -1
        regions.push hotel.region
      hotel.services.forEach (service) ->
        services.push service if services.indexOf(service) == -1
      hotel.infrastructure.forEach (infrastructure) ->
        if infrastructures.indexOf(infrastructure) == -1
          infrastructures.push infrastructure
    $scope.regions = regions
    $scope.services = services
    $scope.infrastructures = infrastructures

  $scope.deleteImage = (index) ->
    images = []
    $scope.hotel.images.forEach (image, pos) ->
      images.push image unless pos == index
    $scope.hotel.images = images

  $scope.serviceSelected = (service) ->
    $scope.hotel.services \
      and $scope.hotel.services.indexOf(service) != -1

  $scope.infrastructureSelected = (infrastructure) ->
    $scope.hotel.infrastructure \
      and $scope.hotel.infrastructure.indexOf(infrastructure) != -1

  $scope.save = ->
    return unless $scope.hotelForm.$valid
    callback = ->
      url = "hotels"
      url += "?country=#{$scope.hotel.country}" if $routeParams.id == "new"
      $location.url url
    if $routeParams.id == "new"
      $scope.hotel.$save callback
    else
      $scope.hotel.$update id: $routeParams.id, callback

  $scope.addImage = ->
    $scope.hotel.images ?= []
    $scope.hotel.images.push ""

  $scope.remove = ->
    if $routeParams.id == "new"
      $location.url "/hotels"
    else if confirm("""Вы точно хотите удалить "#{$scope.hotel.name}"?""")
      $scope.hotel.$remove id: $routeParams.id, ->
        $location.url "/hotels"
