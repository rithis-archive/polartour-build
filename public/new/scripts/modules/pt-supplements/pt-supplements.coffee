ptSupplements = angular.module "ptSupplements", [
  "ngResource"
]

ptSupplements.factory "ptSupplement", ($resource) ->
  $resource "/charges"

ptSupplements.controller "PtSupplementsCtrl", ($scope, $routeParams, ptSupplement) ->
  $scope.supplements = ptSupplement.query country: $routeParams.country
