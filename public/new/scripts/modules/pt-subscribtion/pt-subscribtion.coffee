ptSubscribtion = angular.module "ptSubscribtion", [
  "ngResource"
]

ptSubscribtion.factory "ptSubscribtions", ($resource) ->
  $resource "/subscriptions/:_id"

ptSubscribtion.controller "PtSubscribtionCtrl", ($scope, $location, ptSubscribtions, ptFormDescriptions) ->
  $scope.subscribtion = new ptSubscribtions infoblock: true
  $scope.description = ptFormDescriptions.get code: "subscriptions"

  $scope.send = ->
    if $scope.subscribtionForm.$valid
      $scope.subscribtion.$save ->
        alert "Вы успешно подписались на рассылку"
        $location.url "/"
