polartour.controller "ContactsCtrl", ($scope, Contacts) ->
  $scope.data = Contacts.query()
