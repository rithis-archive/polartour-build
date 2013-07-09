polartourAdmin.controller "PhonesDetailCtrl", ($scope, $location, $routeParams, Phones) ->
  $scope.phone = Phones.get id: $routeParams.id

  $scope.save = ->
    return unless $scope.phoneForm.$valid
    callback = ->
      $location.url "phones"
    if $routeParams.id == "new"
      $scope.phone.$save callback
    else
      $scope.phone.$update id: $routeParams.id, callback