polartourAdmin.controller "CertificationsDetailCtrl", ($scope, $location, $routeParams, Certificates) ->
  $scope.certification = Certificates.get id: $routeParams.id
  
  $scope.remove = ->
    if confirm("""Вы точно хотите удалить эту справку?""")
      $scope.certification.$remove id: $routeParams.id, ->
        $location.url "/ticket-price-requests"

  $scope.changeProcessed = ->
    $scope.certification.$update id: $routeParams.id
