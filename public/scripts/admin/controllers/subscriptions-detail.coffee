polartourAdmin.controller "SubscriptionsDetailCtrl", ($scope, $location, $routeParams, Subscriptions) ->
  $scope.subscription = Subscriptions.get id: $routeParams.id

  $scope.remove = ->
    if confirm("""Вы точно хотите удалить эту подписку?""")
      $scope.subscription.$remove id: $routeParams.id, ->
        $location.url "/subscriptions"

  $scope.changeProcessed = ->
    $scope.subscription.$update id: $routeParams.id
