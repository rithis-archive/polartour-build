ptDocuments = angular.module "ptDocuments", ["ngResource"]


ptDocuments.factory "Documents", ($resource) ->
  $resource "/documents/:id", {}, update: method:'PUT'
