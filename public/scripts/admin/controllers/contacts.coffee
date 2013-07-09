polartourAdmin.controller "ContactsCtrl", ($scope, $location, Contacts) ->
  $scope.data = Contacts.query()

  $scope.new = ->
    $location.url "/contacts/new"
