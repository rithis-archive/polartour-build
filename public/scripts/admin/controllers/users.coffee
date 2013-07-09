polartourAdmin.controller "UsersCtrl", ($scope, $location, Users) ->
  $scope.data = Users.query()

  $scope.new = ->
    $location.url "/users/new"
