ptMenuEdit = angular.module "ptMenuEdit", []


ptMenuEdit.directive "ptMenuEdit", ->
  link: (scope, element, attrs) ->
    element.sortable()
    
    scope.$parent.ranges.push ->
      range = {}
      element.children().each (position, menu) ->
        submenu = {}
        menu = $(menu)
        menu.find(".menu-edit-submenu-item").each (submenuPosition, submenuItem) ->
          submenuId = $(submenuItem).attr "pt-submenu-id"
          submenu[submenuId] = submenuPosition if submenuId
        id = menu.attr "pt-menu-id"
        range[id] = position:position, submenu: submenu if id
      range

ptMenuEdit.directive "ptSubmenuEdit", ->
  link: (scope, element, attrs) ->
    element.sortable()
