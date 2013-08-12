ptAccountingDocuments = angular.module "ptAccountingDocuments", [
  "ngResource"
]

ptAccountingDocuments.factory "PtDocument", ($resource) ->
  $resource "/documents"

ptAccountingDocuments.controller "PtAccountingDocumentsCtrl", ($scope, PtDocument, ptFormDescriptions) ->
  $scope.showValidation = false
  $scope.document = new PtDocument
  $scope.description = ptFormDescriptions.get code: "documents-request"

  $scope.send = ->
    $scope.showValidation = true
    if $scope.documentForm.$valid
      $scope.document.$save ->
        $scope.sent = true
