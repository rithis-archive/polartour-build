ptContacts = angular.module "ptContacts", [
  "ngResource"
]

ptContacts.factory "ptContacts", ($resource) ->
  $resource "/contacts/:_id"

ptContacts.controller "PtContactsCtrl", ($scope, $routeParams, ptContacts) ->
  $scope.departments = ptContacts.query()
