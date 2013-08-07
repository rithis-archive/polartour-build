ptAccountingDocuments = angular.module "ptAccountingDocuments", [
  "ngResource"
]

ptAccountingDocuments.factory "PtDocument", ($resource) ->
  $resource "/documents"

ptAccountingDocuments.controller "PtAccountingDocumentsCtrl", ($scope, PtDocument) ->
  $scope.showValidation = false
  $scope.document = new PtDocument

  $scope.send = ->
    $scope.showValidation = true
    if $scope.documentForm.$valid
      $scope.document.$save ->
        $scope.sent = true
