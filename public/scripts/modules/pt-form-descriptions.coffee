ptFormDescriptions = angular.module "ptFormDescriptions", ["ngResource"]


ptFormDescriptions.factory "FormDescriptions", ($resource) ->
  $resource "/form-descriptions/:code", {}, update: method:'PUT'
