polartourAdmin.controller "CertificatesCtrl", ($scope, Certificates) ->
  $scope.data = Certificates.query()
