ptTowns = angular.module "ptTowns", []

ptTowns.factory "Towns", ($resource) ->
  $resource "/towns/:id", {}, update: method:'PUT'

class TownsManager
  constructor:(Towns) ->
    Towns.query (data) =>
      towns = []
      angular.forEach data, (town) ->
        towns.push town.name
      @towns = towns

      @userTown = store.get("ptTowns.userTown") or @towns[0].name
      $(@).trigger "loaded"

  all: ->
    @towns

  setUserTown: (town) ->
    @userTown = town
    store.set "ptTowns.userTown", town
    $(@).trigger "change"

  getUserTown: ->
    @userTown


ptTowns.service "ptTownsManager", (Towns) ->
  new TownsManager Towns


ptTowns.directive "ptTowns", (ptTownsManager) ->
  (scope) ->
    scope.towns = ptTownsManager.all()
    scope.userTown = ptTownsManager.getUserTown()
    
    $(ptTownsManager).on "loaded", ->
      scope.towns = ptTownsManager.all() unless scope.towns

    $(ptTownsManager).on "change", ->
      unless scope.userTown == ptTownsManager.getUserTown()
        scope.userTown = ptTownsManager.getUserTown()

    scope.$watch "userTown", (town) ->
      ptTownsManager.setUserTown town
      
