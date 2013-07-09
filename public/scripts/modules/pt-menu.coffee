ptMenu = angular.module "ptMenu", ["ngResource"]

class MenuManager
  constructor: (Menu) ->
    @menu = []
    Menu.query (menu) =>
      @menu = menu
      $(@).trigger "loaded"

  getMenu: =>
    @getByType "menu"

  getCountriesMenu: =>
    @getByType "countries"
    
  getByType: (type) ->
    menu = []
    @menu.forEach (item) ->
      menu.push item if item.type == type
    menu

ptMenu.factory "Menu", ($resource) ->
  $resource "/menu/:id", {}, update: method:'PUT'
  
ptMenu.service "ptMenu", (Menu) ->
  new MenuManager Menu
  
ptMenu.directive "ptMenu", (ptMenu) ->
  (scope) ->
    scope.menu = ptMenu.getMenu()

    $(ptMenu).on "loaded", ->
      scope.menu = ptMenu.getMenu()

ptMenu.directive "ptCountriesMenu", (ptMenu, ptCountriesManager) ->
  (scope, element) ->
    current = false
    scope.countriesMenu = ptMenu.getCountriesMenu()

    $(ptMenu).on "loaded", ->
      scope.countriesMenu = ptMenu.getCountriesMenu()

    scope.getCode = (country) ->
      ptCountriesManager.getCode country

ptMenu.directive "ptCountriesMenuItem", ->
  (scope, element) ->
    menu = element.find(".countries-item-menu")
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
