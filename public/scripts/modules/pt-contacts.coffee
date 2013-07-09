ptContacts = angular.module "ptContacts", ["ngResource"]


ptContacts.factory "Contacts", ($resource) ->
  $resource "/contacts/:id", {}, update: method:'PUT'
