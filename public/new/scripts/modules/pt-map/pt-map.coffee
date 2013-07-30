ymaps = angular.module "ymaps", []

ymaps.factory "ymaps", ($window) ->
  $window["ymaps"]

ptMap = angular.module "ptMap", [
  "ymaps"
]

ptMap.directive "ptMap", (ymaps) ->
  scope:
    ptMapLat: "@"
    ptMapLon: "@"
    ptMapZoom: "@"
  restrict: "E"
  templateUrl: "scripts/modules/pt-map/pt-map.html"
  replace: true
  link: (scope, element, attributes) ->
    coordinates = [null, null]
    map = null

    scope.$watch "ptMapLat", (lat) ->
      lat = Number lat
      if lat != coordinates[0]
        coordinates[0] = lat
        setCenter()

    scope.$watch "ptMapLon", (lon) ->
      lon = Number lon
      if lon != coordinates[1]
        coordinates[1] = lon
        setCenter()

    setCenter = ->
      return initMap() unless map
      if typeof coordinates[0] is "number" and typeof coordinates[0] is "number"
        map.setCenter coordinates

    initStarted = false
    initMap = ->
      return if initStarted
      initStarted = true
      ymaps.ready ->
        map = new ymaps.Map element[0],
          center: coordinates
          zoom: Number scope.ptMapZoom
          type: "yandex#hybrid"

        placemark = new ymaps.Placemark coordinates

        map.geoObjects.add placemark

        map.controls
          .add("zoomControl", left: 5, top: 5)
          .add("typeSelector")
          .add("mapTools", left: 35, top: 5)
