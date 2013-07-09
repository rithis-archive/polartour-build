polartourAdmin.controller "UsersDetailCtrl", ($scope, $location, $routeParams, Users) ->
  $scope.user = if $routeParams.id is "new" then new Users \
    else Users.get id: $routeParams.id

  $scope.save = ->
    callback = ->
      $location.url "users"
    if $routeParams.id == "new"
      $scope.user.$save callback
    else
      $scope.user.$update id: $routeParams.id, callback


  $scope.remove = ->
    if $routeParams.id == "new"
      $location.url "/users"
    else if confirm("""Вы точно хотите удалить "#{$scope.user.title}"?""")
      $scope.users.$remove id: $routeParams.id, ->
        $location.url "/users"
