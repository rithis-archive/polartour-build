ptFeedback = angular.module "ptFeedback", [
  "ngResource"
]

ptFeedback.factory "ptFeedbacks", ($resource) ->
  $resource "/reports/:_id"

ptFeedback.controller "PtFeedbackCtrl", ($scope, $location, ptFeedbacks, ptFormDescriptions) ->
  $scope.showValidation = false
  $scope.feedback = new ptFeedbacks
  $scope.description = ptFormDescriptions.get code: "feedback"

  $scope.send = ->
    $scope.showValidation = true
    if $scope.feedbackForm.$valid
      $scope.feedback.$save ->
        alert "Спасибо! Ваше письмо успешно сохранено."
        $location.url "/"
