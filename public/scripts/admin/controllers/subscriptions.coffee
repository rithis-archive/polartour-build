polartourAdmin.controller "SubscriptionsCtrl", ($scope, Subscriptions, $cookieStore) ->
  $scope.data = Subscriptions.query()
  $scope.token = store.get "token"
