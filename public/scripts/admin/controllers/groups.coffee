polartourAdmin.controller "GroupsCtrl", ($scope, $location, Groups) ->
  $scope.data = Groups.query()

  $scope.new = ->
    $location.url "/groups/new"
