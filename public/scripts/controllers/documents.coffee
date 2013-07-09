polartour.controller "DocumentsCtrl", ($scope, $location, Documents, FormDescriptions) ->
  $scope.doc = new Documents
  $scope.description = FormDescriptions.get code: "documents-request"

  $scope.send = ->
    if $scope.documentsForm.$valid
      $scope.doc.$save ->
        alert "Ваш запрос успешно сохранен."
        $location.url "/"
