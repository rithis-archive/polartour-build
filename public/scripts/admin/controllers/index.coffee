polartourAdmin.controller "IndexCtrl", ($scope, $location, user) ->
  $location.url "/login" unless user.isAuthenticated()
