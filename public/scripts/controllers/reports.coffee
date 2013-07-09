polartour.controller "ReportsCtrl", ($scope, $location, Reports, FormDescriptions) ->
  $scope.report = new Reports
  $scope.description = FormDescriptions.get code: "feedback"

  $scope.send = ->
    if $scope.reportForm.$valid
      $scope.report.$save ->
        alert "Спасибо! Ваше письмо успешно сохранено."
        $location.url "/"
