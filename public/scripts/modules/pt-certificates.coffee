ptCertificates = angular.module "ptCertificates", ["ngResource"]


ptCertificates.factory "Certificates", ($resource) ->
  $resource "/certificates/:id", {}, update: method:'PUT'
