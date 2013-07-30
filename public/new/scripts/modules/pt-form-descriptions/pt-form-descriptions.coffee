ptFormDescriptions = angular.module "ptFormDescriptions", ["ngResource"]

ptFormDescriptions.factory "ptFormDescriptions", ($resource) ->
  $resource "/form-descriptions/:code"
