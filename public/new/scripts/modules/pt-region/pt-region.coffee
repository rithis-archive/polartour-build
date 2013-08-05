ptRegion = angular.module "ptRegion", []

ptRegion.factory "ptRegion", ->
  regions:
    mow: "Москва"
    led: "Санкт-Петербург"
    svx: "Екатеринбург"
    kuf: "Самара"
    rov: "Ростов-на-Дону"
    ufa: "Уфа"
    kzn: "Казань"
  samoIds:
    mow: 2   # moscow
    kuf: 42  # samara
    kzn: 48  # kazan
    rov: 64  # rostov on don
    svx: 70  # ekaterinburg
    led: 80  # st petersburg
    ufa: 116 # ufa
  setRegion: (key) ->
    store.set "ptRegion", key
  getRegion: ->
    region = store.get("ptRegion")
    if @regions[region]
      region
    else
      "mow"
  getRegionSamoId: ->
    @samoIds[@getRegion()]

ptRegion.controller "PtRegionCtrl", ($scope, ptRegion) ->
  $scope.regions = ptRegion.regions
  $scope.region = ptRegion.getRegion()

  $scope.$watch "region", (region) ->
    ptRegion.setRegion region
