polartour.controller "CertificatesCtrl", ($scope, $location, Certificates, FormDescriptions) ->
  $scope.certificate = new Certificates 
    tourists: [""]

  $scope.description = FormDescriptions.get code: "ticket-price-request"

  $scope.send = ->
    if $scope.certificateForm.$valid
      $scope.certificate.$save ->
        alert "Ваш запрос успешно сохранен, ожидайте ответное письмо."
        $location.url "/"
