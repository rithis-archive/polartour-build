ptReports = angular.module "ptReports", ["ngResource"]


ptReports.factory "Reports", ($resource) ->
  $resource "/reports/:id", {}, update: method:'PUT'
