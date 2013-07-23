ptFiles = angular.module "ptFiles", []

ptFiles.factory "Files", ($resource) ->
  $resource "/files/:id", {}, update: method: "PUT"
