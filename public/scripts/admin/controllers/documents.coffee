polartourAdmin.controller "DocumentsCtrl", ($scope, Documents) ->
  $scope.data = Documents.query()
