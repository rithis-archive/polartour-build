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

ptMenu.directive "ptMenu", (ptMenuManager, ptSamo) ->
  restrict: "E"
  templateUrl: "scripts/modules/pt-menu/pt-menu.html"
  replace: true
  link: (scope) ->
    scope.menu = ptMenuManager.getMenu()

    scope.openPersonalCabinet = ->
      ptSamo.openPersonalCabinet()

    $(ptMenuManager).on "loaded", ->
      scope.menu = ptMenuManager.getMenu()

ptMenu.directive "ptCountriesMenu", (ptMenuManager) ->
  restrict: "E"
  templateUrl: "scripts/modules/pt-menu/pt-countries-menu.html"
  replace: true
  scope: {}
  link: (scope, element, attrs) ->
    scope.white = false
    scope.countriesMenu = ptMenuManager.getCountriesMenu()

    scope.$watch attrs.ptCountriesWhite, (value) ->
      scope.white = value

    $(ptMenuManager).on "loaded", ->
      scope.countriesMenu = ptMenuManager.getCountriesMenu()

ptMenu.directive "ptCountriesMenuItem", ->
  restrict: "EACM"
  link: (scope, element) ->
    menu = element.find(".country__nav")
    timer = null
    lastAction = new Date()

    element.mouseenter ->
      lastAction = new Date()

      timer = setTimeout ->
        menu.show()
      , 300

    element.mouseleave ->
      if (new Date()) - lastAction < 300
        clearTimeout timer
      else
        menu.hide()

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
