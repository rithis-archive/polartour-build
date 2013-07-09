polartourAdmin.controller "ChargesDetailCtrl", ($scope, $location, $routeParams, Charges) ->
  $scope.charge = if $routeParams.id is "new" then new Charges \
    else Charges.get id: $routeParams.id

  $scope.save = ->
    return unless $scope.chargeForm.$valid
    callback = ->
      $location.url "charges"
    if $routeParams.id == "new"
      $scope.charge.$save callback
    else
      $scope.charge.$update id: $routeParams.id, callback

  $scope.remove = ->
    if $routeParams.id == "new"
      $location.url "/charges"
    else if confirm("""Вы точно хотите удалить эту доплату?""")
      $scope.charge.$remove id: $routeParams.id, ->
        $location.url "/charges"
