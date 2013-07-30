ptMenu = angular.module "ptMenu", [
  "ngResource"
]

class MenuManager
  constructor: (Menu, ptCountriesManager) ->
    @ptCountriesManager = ptCountriesManager
    @menu = []
    Menu.query (menu) =>
      @menu = menu
      $(@).trigger "loaded"

  getMenu: =>
    @getByType "menu"

  getCountriesMenu: =>
    @getByType "countries"
    
  getByType: (type) =>
    menu = []
    @menu.forEach (item) =>
      if item.type is "countries"
        item.code = @ptCountriesManager.getCode item.name
      menu.push item if item.type == type
    menu

ptMenu.factory "ptMenu", ($resource) ->
  $resource "/menu"

ptMenu.service "ptMenuManager", (ptMenu, ptCountriesManager) ->
  new MenuManager ptMenu, ptCountriesManager

ptMenu.directive "ptMenu", (ptMenuManager) ->
  restrict: "E"
  templateUrl: "scripts/modules/pt-menu/pt-menu.html"
  replace: true
  link: (scope) ->
    scope.menu = ptMenuManager.getMenu()

    $(ptMenuManager).on "loaded", ->
      scope.menu = ptMenuManager.getMenu()

ptMenu.directive "ptCountriesMenu", (ptMenuManager) ->
  restrict: "E"
  templateUrl: "scripts/modules/pt-menu/pt-countries-menu.html"
  replace: true
  link: (scope, element, attrs) ->
    scope.type = attrs.ptCountriesMenuType or "white"
    scope.countriesMenu = ptMenuManager.getCountriesMenu()

    $(ptMenuManager).on "loaded", ->
      scope.countriesMenu = ptMenuManager.getCountriesMenu()

ptMenu.directive "ptFooterMenu", (ptMenuManager) ->
  restrict: "E"
  templateUrl: "scripts/modules/pt-menu/pt-footer-menu.html"
  replace: true
  link: (scope) ->
    scope.countriesMenu = ptMenuManager.getCountriesMenu()
    scope.menu = ptMenuManager.getMenu()

    $(ptMenuManager).on "loaded", ->
      scope.countriesMenu = ptMenuManager.getCountriesMenu()
      scope.menu = ptMenuManager.getMenu()
