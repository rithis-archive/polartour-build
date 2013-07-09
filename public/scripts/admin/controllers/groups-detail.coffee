polartourAdmin.controller "GroupsDetailCtrl", ($scope, $location, $routeParams, $timeout, Groups, Permissions, Users) ->
  $scope.group = if $routeParams.id is "new" then new Groups \
    else Groups.get id: $routeParams.id

  $scope.actions =
    "get": "Просматривать"
    "post": "Создавать"
    "put": "Редактировать"
    "delete": "Удалять"

  $timeout ->
    $scope.permissions = Permissions.query()
    $scope.users = Users.query()
  
  $scope.hasUser = (user) ->
    $scope.group.users and $scope.group.users.indexOf(user) != -1

  $scope.addUser = (user) ->
    $scope.group.users ?= []
    $scope.group.users.push user

  $scope.removeUser = (user) ->
    return unless $scope.group.users
    index = $scope.group.users.indexOf user
    unless index == -1
      $scope.group.users.splice index, 1

  $scope.hasPermission = (permission, action) ->
    return unless $scope.group.permissions
    exists = false
    $scope.group.permissions.forEach (item) ->
      exists = true if item[permission] is action
    exists

  $scope.addPermission = (permission, action) ->
    item = {}
    item[permission] = action
    $scope.group.permissions ?= []
    $scope.group.permissions.push item

  $scope.removePermission = (permission, action) ->
    return unless $scope.group.permissions
    index = null
    $scope.group.permissions.forEach (item, position) ->
      index = position if item[permission] is action
    $scope.group.permissions.splice index, 1 if index

  $scope.save = ->
    callback = ->
      $location.url "groups"
    if $routeParams.id == "new"
      $scope.group.$save callback
    else
      $scope.group.$update id: $routeParams.id, callback

  $scope.remove = ->
    if $routeParams.id == "new"
      $location.url "/groups"
    else if confirm("""Вы точно хотите удалить "#{$scope.news.title}"?""")
      $scope.group.$remove id: $routeParams.id, ->
        $location.url "/groups"
