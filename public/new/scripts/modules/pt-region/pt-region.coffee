ptRegion = angular.module "ptRegion", []

ptRegion.factory "ptRegion", ->
  regions:
    msk: "Москва"
    spb: "Санкт-Петербург"
    ekt: "Екатеринбург"
    sam: "Самара"
    ros: "Ростов-на-Дону"
    ufa: "Уфа"
    kaz: "Казань"
  setRegion: (key) ->
    store.set "ptRegion", key
  getRegion: ->
    store.get("ptRegion") or "msk"

ptRegion.controller "PtRegionCtrl", ($scope, ptRegion) ->
  $scope.regions = ptRegion.regions
  $scope.region = ptRegion.getRegion()

  $scope.$watch "region", (region) ->
    ptRegion.setRegion region
