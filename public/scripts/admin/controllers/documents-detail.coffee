polartourAdmin.controller "DocumentsDetailCtrl", ($scope, $location, $routeParams, Documents) ->
  $scope.doc = Documents.get id: $routeParams.id
  
  $scope.remove = ->
    if confirm("""Вы точно хотите удалить этот документ?""")
      $scope.doc.$remove id: $routeParams.id, ->
        $location.url "/documents-requests"

  $scope.changeProcessed = ->
    $scope.doc.$update id: $routeParams.id
