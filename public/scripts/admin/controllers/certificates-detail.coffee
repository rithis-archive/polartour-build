polartourAdmin.controller "CertificationsDetailCtrl", ($scope, $location, $routeParams, Certificates) ->
  $scope.certification = Certificates.get id: $routeParams.id
