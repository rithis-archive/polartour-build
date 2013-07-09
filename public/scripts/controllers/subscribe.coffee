polartour.controller "SubscribeCtrl", ($scope, $location, Subscriptions, FormDescriptions) ->
  $scope.subscription = new Subscriptions

  $scope.description = FormDescriptions.get code: "subscriptions"

  $scope.send = ->
    if $scope.subscribeForm.$valid
      $scope.subscription.$save ->
        alert "Вы успешно подписались на рассылку"
        $location.url "/"

  $("input").iCheck
    checkboxClass: "icheckbox_polartour"
    increaseArea: "20%"
