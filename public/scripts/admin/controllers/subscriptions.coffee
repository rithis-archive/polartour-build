polartourAdmin.controller "SubscriptionsCtrl", ($scope, Subscriptions) ->
  $scope.data = Subscriptions.query()
