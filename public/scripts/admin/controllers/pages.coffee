polartourAdmin.controller "PagesCtrl", ($scope, $location, Pages) ->
  $scope.data = Pages.query()

  $scope.new = ->
    $location.url "/pages/new"
