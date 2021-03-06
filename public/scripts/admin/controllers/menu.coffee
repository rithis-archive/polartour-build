polartourAdmin.controller "MenuCtrl", ($scope, Menu) ->
  $scope.hidden = {}
  $scope.ranges = []

  Menu.query (data) ->
    menu = []
    countriesMenu = []
    data.forEach (item) ->
      menu.push item if item.type == "menu"
      countriesMenu.push item if item.type == "countries"
  
    $scope.data =
      menu: title: "основное меню", menu: menu
      countries: title: "меню стран", menu: countriesMenu

  $scope.add = (type) ->
    $scope.data[type].menu.push
      submenu: [{}],
      type: type,
      active: true
      isNew: true
      _id: (new Date()).getTime().toString()

  $scope.addSubmenu = (menu) ->
    menu.submenu.push
      active: true
      newWindow: false
      isNew: true
      _id: (new Date()).getTime().toString()

  $scope.remove = (type, item) ->
    callback = ->
      updated = []
      $scope.data[type].menu.forEach (menu) ->
        updated.push menu unless item == menu
      $scope.data[type].menu = updated

    return callback() unless item._id

    if confirm("""Вы точно хотите удалить это меню?""")
      menu = new Menu item
      menu.$remove id: item._id, callback
      

  $scope.removeSubmenu = (menu, item) ->
    updated = []
    menu.submenu.forEach (submenu) ->
      updated.push submenu unless item == submenu
    menu.submenu = updated
    
  $scope.save = ->
    menus = []
    $scope.ranges.forEach (range) ->
      for id, menu of range()
        for type, items of $scope.data
          items.menu.forEach (item) ->
            if item._id == id
              submenu = []
              item.submenu.forEach (submenuItem) ->
                for submenuId, position of menu.submenu
                  if submenuItem._id == submenuId
                    data = 
                      position: position
                      href: submenuItem.href
                      name: submenuItem.name
                      newWindow: submenuItem.newWindow
                      active: submenuItem.active
                    data._id = submenuId unless submenuItem.isNew
                    submenu.push data
              menus.push
                _id: id unless item.isNew,
                position: menu.position
                submenu: submenu
                href: item.href
                name: item.name
                newWindow: item.newWindow
                active: item.active
                type: type

    $.ajax
      type: "PATCH"
      dataType: "json"
      contentType: "application/json"
      url: "/menu"
      data: JSON.stringify menus
      
    return
    menu = []
    for type, item of $scope.data
      menu = menu.concat item.menu

    menu.forEach (data) ->
      item = new Menu data
      
      if data._id
        item.$update id: data._id
      else
        item.$save()
      
