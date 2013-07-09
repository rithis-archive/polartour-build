ptCharges = angular.module "ptCharges", ["ngResource"]


ptCharges.factory "Charges", ($resource) ->
  $resource "/charges/:id", {}, update: method:'PUT'
