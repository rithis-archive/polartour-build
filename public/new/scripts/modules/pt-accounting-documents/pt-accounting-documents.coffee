ptAccountingDocuments = angular.module "ptAccountingDocuments", [
  "ngResource"
]

ptAccountingDocuments.factory "PtDocument", ($resource) ->
  $resource "/documents"

ptAccountingDocuments.controller "PtAccountingDocumentsCtrl", ($scope, PtDocument) ->
  $scope.document = new PtDocument

  $scope.send = (document, form) ->
    for name, field of form
      if field.$setViewValue
        field.$setViewValue field.$viewValue
    if form.$valid
      document.$save ->
        $scope.sent = true
