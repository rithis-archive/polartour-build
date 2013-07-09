polartourAdmin.controller "LoginCtrl", ($scope, $location, user) ->
  $scope.user = {}

  $scope.submit = ->
    user.auth $scope.user.username, $scope.user.password, (auth) ->
      $location.url "/" if auth
