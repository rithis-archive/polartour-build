polartourAdmin.controller "PhonesCtrl", ($scope, Phones) ->
  $scope.data = Phones.query()
