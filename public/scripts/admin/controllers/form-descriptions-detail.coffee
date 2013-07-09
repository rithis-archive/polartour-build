polartourAdmin.controller "FormDescriptionsDetailCtrl", ($scope, $location, $routeParams, FormDescriptions) ->
  $scope.description = FormDescriptions.get code: $routeParams.code

  $scope.save = ->
    callback = ->
      $location.url "form-descriptions"
    setTimeout ->
      $scope.description.$update code: $routeParams.code, callback
    , 200
