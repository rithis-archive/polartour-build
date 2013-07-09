polartourAdmin.controller "FormDescriptionsCtrl", ($scope, $location, FormDescriptions) ->
  $scope.data = FormDescriptions.query()
