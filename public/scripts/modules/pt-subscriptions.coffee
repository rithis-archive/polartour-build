ptSubscriptions = angular.module "ptSubscriptions", ["ngResource"]


ptSubscriptions.factory "Subscriptions", ($resource) ->
  $resource "/subscriptions/:id", {}, update: method:'PUT'
