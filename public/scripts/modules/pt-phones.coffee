ptPhones = angular.module "ptPhones", ["ngResource"]


ptPhones.factory "Phones", ($resource) ->
  $resource "/phones/:id", {}, update: method:'PUT'


ptPhones.directive "ptPhones", (Phones) ->
  (scope) ->
    scope.phones = Phones.query()