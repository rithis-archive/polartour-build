ptPhones = angular.module "ptPhones", [
  "ngResource"
]

ptPhones.factory "ptPhone", ($resource) ->
  $resource "/phones"

ptPhones.factory "ptPhones", (ptPhone) ->
  phones: ptPhone.query()

ptPhones.directive "ptPhones", (ptPhones) ->
  restrict: "E"
  templateUrl: "scripts/modules/pt-phones/pt-phones.html"
  replace: true
  link: (scope) ->
    scope.phones = ptPhones.phones
