polartourAdmin.controller "SubscriptionsDetailCtrl", ($scope, $location, $routeParams, Subscriptions) ->
  $scope.subscription = Subscriptions.get id: $routeParams.id
