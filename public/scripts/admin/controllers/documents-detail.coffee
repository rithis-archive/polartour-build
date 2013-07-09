polartourAdmin.controller "DocumentsDetailCtrl", ($scope, $location, $routeParams, Documents) ->
  $scope.doc = Documents.get id: $routeParams.id
