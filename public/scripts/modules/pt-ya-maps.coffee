ymaps = angular.module "ymaps", []
ymaps.factory "ymaps", ($window) ->
  $window["ymaps"]
      
ptYaMaps = angular.module "ptYaMaps", ["ymaps"]

ptYaMaps.directive "map", (ymaps) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    initYmaps = ->
      ymaps.ready ->
        coordinates = [Number(attrs.lat), Number(attrs.lon)]
  
        map = new ymaps.Map element[0],
          center: coordinates
          zoom: Number attrs.zoom
          type: attrs.type if attrs.type
  
        placemark = new ymaps.Placemark coordinates
        
        map.geoObjects.add placemark
  
        map.controls
          .add("zoomControl", left: 5, top: 5)
          .add("typeSelector")
          .add("mapTools", left: 35, top: 5)
        
        map.events.add "click", (e) ->
          coords = e.get "coordPosition"

          scope.$eval "#{attrs.ngModel} = [#{coords.join(',')}]" if attrs.ngModel

          ymaps.geocode(coords).then (res) ->
            names = []

            res.geoObjects.each (obj) ->
              names.push obj.properties.get "name"

            while obj = map.geoObjects.getIterator().getNext()
              map.geoObjects.remove obj

            map.geoObjects.add new ymaps.Placemark coords,
              iconContent:names[0],
              balloonContent:names.reverse().join(', ')
            ,
              preset:'twirl#redStretchyIcon',
              balloonMaxWidth:'250'

        return unless attrs.search
  
        searchControl = new ymaps.control.SearchControl()
  
        map.controls
          .add searchControl, right: 400, top: 6

    if attrs.lat and attrs.lon
      initYmaps()
    else
      init = false
      scope.$watch attrs.ngModel, (newVal, oldVal, scope) ->
        return if init
        return unless newVal

        initYmaps()
        init = true
