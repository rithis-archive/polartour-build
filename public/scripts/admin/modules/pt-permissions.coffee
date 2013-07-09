ptPermissions = angular.module "ptPermissions", ["ngResource"]


ptPermissions.factory "Groups", ($resource) ->
  $resource "/groups/:id", {}, update: method:'PUT'


ptPermissions.factory "Permissions", ($resource) ->
  $resource "/permissions/:id", {}, update: method:'PUT'


ptPermissions.factory "Users", ($resource) ->
  $resource "/users/:id", {}, update: method:'PUT'