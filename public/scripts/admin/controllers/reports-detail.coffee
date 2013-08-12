polartourAdmin.controller "ReportsDetailCtrl", ($scope, $location, $routeParams, Reports) ->
  $scope.report = Reports.get id: $routeParams.id

  $scope.remove = ->
    if confirm("""Вы точно хотите удалить этот отзыв?""")
      $scope.report.$remove id: $routeParams.id, ->
        $location.url "/feedbacks"

  $scope.changeProcessed = ->
    $scope.report.$update id: $routeParams.id
